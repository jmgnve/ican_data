

########################################################################

# Write/append data to one input file for vic

write_met_input <- function(file_vic, prec, tmin, tmax, wind) {
  
  # Multipliers
  
  prec <- as.integer(prec * 100) # Precipitation in mm/day
  tmin <- as.integer(tmin * 100) # Temperature in degree Centigrades
  tmax <- as.integer(tmax * 100)
  wind <- as.integer(wind * 100) # Wind in m/s
  
  # Write the data to files
  
  writeBin(prec, file_vic, endian = "little", size = 2)
  writeBin(tmin, file_vic, endian = "little", size = 2)
  writeBin(tmax, file_vic, endian = "little", size = 2)
  writeBin(wind, file_vic, endian = "little", size = 2)
  
}

########################################################################

# Read binary vic input file

read_met_input <- function(filename) {
  
  # Check file length
  
  file_vic <- file(filename, "rb")
  
  nall <- 0
  
  while (length(readBin(file_vic, integer(), size = 2)) > 0) {
    nall <- nall + 1
  }
  
  close(file_vic)
  
  # Read data
  
  nrec <- nall/4
  
  prec <- matrix(data=NA, nrow=nrec, ncol=1)
  tmin <- matrix(data=NA, nrow=nrec, ncol=1)
  tmax <- matrix(data=NA, nrow=nrec, ncol=1)
  wind <- matrix(data=NA, nrow=nrec, ncol=1)
  
  file_vic <- file(filename, "rb")
  
  for (i in 1:(nrec)) {
    
    prec[i] <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 100
    tmin[i] <- readBin(file_vic, integer(), size = 2, signed = TRUE) / 100
    tmax[i] <- readBin(file_vic, integer(), size = 2, signed = TRUE) / 100
    wind[i] <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 100
    
  }
  
  close(file_vic)
  
  # Return results
  
  return(list(prec = prec, tmin = tmin, tmax = tmax, wind = wind))
  
}

########################################################################

# Read binary vic output file

read_met_output <- function(filename,nyear) {
  
  #ptm <- proc.time()
  
  file_vic <- file(filename, "rb")
  
  all <- readBin(file_vic, integer(), n=366*nyear*8, size=2,signed = TRUE) 
  close(file_vic)
  
  # Read data
  nall <- length(all)
  nrec <- nall/8
  selec <- seq(1,(nrec-1)*8+1,8)
  
  prec <- all[selec]/40
  tair <- all[(selec+1)]/100
  iswr <- all[(selec+2)]/50
  ilwr <- all[(selec+3)]/80
  pres <- all[(selec+4)]/100
  qair <- all[(selec+5)]/100000
  vp   <- all[(selec+6)]/100
  wind <- all[(selec+7)]/100

  
  # Return results
  
  return(list(prec = prec, tair = tair, iswr = iswr, ilwr = ilwr,
              pres = pres, qair = qair, vp = vp, wind = wind))
  
}












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

read_met_output <- function(filename) {
  
  # Check file length
  
  file_vic <- file(filename, "rb")
  
  nall <- 0
  
  while (length(readBin(file_vic, integer(), size = 2)) > 0) {
    nall <- nall + 1
  }
  
  close(file_vic)
  
  # Read data
  
  nrec <- nall/8
  
  prec <- matrix(data=NA, nrow=nrec, ncol=1)
  tair <- matrix(data=NA, nrow=nrec, ncol=1)
  iswr <- matrix(data=NA, nrow=nrec, ncol=1)
  ilwr <- matrix(data=NA, nrow=nrec, ncol=1)
  pres <- matrix(data=NA, nrow=nrec, ncol=1)
  qair <- matrix(data=NA, nrow=nrec, ncol=1)
  vp   <- matrix(data=NA, nrow=nrec, ncol=1)
  wind <- matrix(data=NA, nrow=nrec, ncol=1)
  
  file_vic <- file(filename, "rb")
  
  for (i in 1:(nrec)) {
    
    prec[i] <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 40
    tair[i] <- readBin(file_vic, integer(), size = 2, signed = TRUE) / 100
    iswr[i] <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 50
    ilwr[i] <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 80
    pres[i] <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 100
    qair[i] <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 100000
    vp[i]   <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 100
    wind[i] <- readBin(file_vic, integer(), size = 2, signed = FALSE) / 100
    
  }
  
  close(file_vic)
  
  # Return results
  
  return(list(prec = prec, tair = tair, iswr = iswr, ilwr = ilwr,
              pres = pres, qair = qair, vp = vp, wind = wind))
  
}


########################################################################

# Read Ingjerds input file

filename <- "//unixhome/users/jmg/Projects/VIC_MTCLIM/test_iha/forcing/iha_data_57.98290_7.04963"

data_iha <- read_met_input(filename)

# Write as input to vic

filename <- "//unixhome/users/jmg/Projects/VIC_MTCLIM/test_iha/forcing/data_57.98290_7.04963"

file_vic <- file(filename, "wb")

for (i in 1:length(data_iha$prec)) {
  
  prec <- data_iha$prec[i]
  tmin <- data_iha$tmin[i]
  tmax <- data_iha$tmax[i]
  wind <- data_iha$wind[i]
  
  write_met_input(file_vic, prec, tmin, tmax, wind)
  
}

close(file_vic)



### RUN VIC MTCLIM AT THIS POINT ###




# Read Ingjers output

filename <- "//unixhome/users/jmg/Projects/VIC_MTCLIM/test_iha/results/iha_full_data_57.98290_7.04963"

data_iha <- read_met_output(filename)

# Read Jans output

filename <- "//unixhome/users/jmg/Projects/VIC_MTCLIM/test_iha/results/jan_full_data_57.98290_7.04963"

data_jan <- read_met_output(filename)

# Plot results

plot(data_iha$prec[1000:2000], type = "l", ylab = "Precipitation")
lines(data_jan$prec[1000:2000], lty = 2, col = "red")

plot(data_iha$tair[1000:2000], type = "l", ylab = "Air temperature")
lines(data_jan$tair[1000:2000], lty = 2, col = "red")

plot(data_iha$iswr[1000:1300], type = "l", ylab = "Shortwave radiation")
lines(data_jan$iswr[1000:1300], lty = 2, col = "red")

plot(data_iha$ilwr[1000:2000], type = "l", ylab = "Longwave radiation")
lines(data_jan$ilwr[1000:2000], lty = 2, col = "red")

plot(data_iha$pres[1000:2000], type = "l", ylab = "Air pressure")
lines(data_jan$pres[1000:2000], lty = 2, col = "red")

plot(data_iha$qair[1000:2000], type = "l", ylab = "Specific humidity?")
lines(data_jan$qair[1000:2000], lty = 2, col = "red")

plot(data_iha$vp[1000:2000], type = "l", ylab = "Vapor pressure")
lines(data_jan$vp[1000:2000], lty = 2, col = "red")









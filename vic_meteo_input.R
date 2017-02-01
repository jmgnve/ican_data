
write_met_input <- function(path_sim, syear, eyear) {
  
  #########################################################################################################
  
  # Scaling parameter for bil files
  
  scale <- 10
  
  # Paths to meteorological data
  
  path_prec_bil <- "//hdata/grid/metdata/met_obs_v2.1/rr"
  path_tmin_bil <- "//hdata/grid2/metdata/klinogrid/tn24h06"
  path_tmax_bil <- "//hdata/grid2/metdata/klinogrid/tx24h06"
  path_wind_bil <- "//hdata/grid2/metdata/klinogrid/ffm24h06"
  
  # Path for storing the results
  
  path_met <- file.path(path_sim, "forcing")
  
  #########################################################################################################
  
  # Delete all files in the "path_met" folder
  
  print(paste("Delete old files in folder ", path_met))
  
  dummy <- file.remove(file.path(path_met, list.files(path_met)))
  
  # Names for vic input files (coordinates from InnenforNorge.txt)
  
  print("Processing InnenforNorge.txt")
  
  df_in_norway <- read.csv("InnenforNorge.txt", header = TRUE, sep = ";")
  
  fn_vic_input <- vector(mode = "character", length = nrow(df_in_norway))
  id_bil_file <- vector(mode = "numeric", length = nrow(df_in_norway))
  lat <- vector(mode = "numeric", length = nrow(df_in_norway))
  lon <- vector(mode = "numeric", length = nrow(df_in_norway))
  
  for (irow in 1:nrow(df_in_norway)) {
    
    id_bil_file[irow] <- df_in_norway$TABID[irow] + 1
    
    lat[irow] <- format(df_in_norway$POINT_Y[irow], nsmall = 5, digits = 5)
    lon[irow] <- format(df_in_norway$POINT_X[irow], nsmall = 5, digits = 5)
    
    file_tmp <- paste("data", lat[irow], lon[irow], sep = "_")
    
    fn_vic_input[irow] <- file.path(path_met, file_tmp)
    
  }
  
  # Loop over years
  
  pr_acc <- 0  # Array for computing accumulated precipitation
  ndays <- 0  # Number of days
  nwrong <- 0  # Number of days with tmax<tmin
  
  nyear <- length(syear:eyear)
  
  missing_files <- c()
  
  for ( i in syear:eyear) {
    
    days <- seq(ISOdate(i,1,1),ISOdate(i ,12,31),"day")
    s1 <- as.POSIXlt(days)$year+1900
    s2 <- as.POSIXlt(days)$mon+1
    s3 <- as.POSIXlt(days)$mday
    
    # Allocate output array
    
    data_all <- matrix(data = 0, nrow = 4*length(days), ncol = length(id_bil_file))
    
    # Loop over days
    
    for (j in 1:length(days)) {
      
      if(s2[j]<10) {
        mname <- paste("0",s2[j],sep="")
      } else {
        mname <- s2[j]
      }
      
      if(s3[j]<10) {
        dname <- paste("0",s3[j],sep="")
      } else {
        dname <- s3[j]
      }
      
      time_name <- paste(s1[j],"_",mname,"_",dname,".bil",sep="")
      
      # tmax
      
      filename <- paste(path_tmax_bil,"/",i,"/tx24h06_",time_name,sep="")
      
      if (file.exists((filename))) {
      
        indata <- file(filename,"rb")
        run <- readBin(indata, integer(), n=1195*1550, size=2)   # for temperature
        close(indata)
        
        tmax <- (run[id_bil_file]-2731)/scale
        
        
      } else {
        
        missing_files <- c(missing_files, filename)
        
      }
      
      #tmin
      
      filename <- paste(path_tmin_bil,"/",i,"/tn24h06_",time_name,sep="")
      
      if (file.exists((filename))) {
        
        indata <- file(filename,"rb")
        run <- readBin(indata, integer(), n=1195*1550, size=2)   # for temperature
        close(indata)
        
        tmin <- (run[id_bil_file]-2731)/scale
        
      } else {
        
        missing_files <- c(missing_files, filename)
        
      }
      
      # prcp
      
      filename <- paste(path_prec_bil,"/",i,"/rr_",time_name,sep="")
      
      if (file.exists((filename))) {
        
        indata <- file(filename,"rb")
        run <- readBin(indata, integer(), n=1195*1550, size=2)   # for precipitation
        close(indata)
        
        pr <- run[id_bil_file]/scale
        
      } else {
        
        missing_files <- c(missing_files, filename)
        
      }
      
      # wind
      
      filename <- paste(path_wind_bil,"/",i,"/ffm24h06_",time_name,sep="")
      
      if (file.exists((filename))) {
        
        indata <- file(filename,"rb")
        run <- readBin(indata, integer(), n=1195*1550, size=2)   # for wind
        close(indata)
        
        wind <- run[id_bil_file]/scale
        
      } else {
        
        missing_files <- c(missing_files, filename)
        
      }
      
      # check consistency between tmax and tmin
      
      iwrong <- tmin > tmax
      
      if (any(iwrong) == TRUE) {
        
        ttmp <- tmin[iwrong]
        
        tmin[iwrong] <- tmax[iwrong]
        tmax[iwrong] <- ttmp
        
        print("Tmax was lower than tmin!!!")
        
        nwrong <- nwrong + 1
        
      }
      
      # Correct precipitation
      
      Tmean <- (tmax+tmin)/2
      Windspeed_at_gauge <- (log(1/0.03)/log(10/0.03))*wind 
      Windspeed_at_gauge[which(Windspeed_at_gauge>6.5)] <- 6.5
      
      select <- which(Tmean< (-1.5))
      pr[select] <- pr[select]*(1/((100-11.95*Windspeed_at_gauge[select]+Windspeed_at_gauge[select]*Windspeed_at_gauge[select]*0.55)/100))
      
      select <- which(Tmean>= (-1.5)&Tmean <0.5)
      pr[select] <- pr[select]*(1/((100-8.16*Windspeed_at_gauge[select]+Windspeed_at_gauge[select]*Windspeed_at_gauge[select]*0.45)/100))
      
      select <- which(Tmean>=0.5)
      pr[select] <- pr[select]*(1/((100-3.37*Windspeed_at_gauge[select]+Windspeed_at_gauge[select]*Windspeed_at_gauge[select]*0.35)/100))
      
      # Save the daily outputs into one matrix
      
      iarray = 4*j - 3
      
      data_all[iarray, ]   <- pr
      data_all[iarray+1, ] <- tmin
      data_all[iarray+2, ] <- tmax
      data_all[iarray+3, ] <- wind
      
      # Accumulate precipitation
      
      pr_acc <- pr_acc + pr
      ndays <- ndays + 1
      
      # Print progress
      
      print(paste("Processed", time_name, sep = " "))
      
    }  # end j
    
    # Write data to binary files for VIC
    
    for (nfile in 1:length(id_bil_file)) {
      
      # Open vic input files for writing
      
      file_vic <- file(fn_vic_input[nfile], "ab")
      
      # Convert to integer and append to file
      
      data_vec <- as.integer(data_all[, nfile] * 100)
      
      # data_vec <- data_all[, nfile]
      
      writeBin(data_vec, file_vic, endian = "little", size = 2)
      
      # Close connection
      
      close(file_vic)
      
      # Write progress
      
      if (nfile%%10000 == 0) {
        print(paste("Wrote file ", nfile, sep = ""))
      }
      
    }
    
  } # end i
  
  # Print wrong days
  
  print(paste("Number of days with tmax<tmin: ", nwrong, sep = ""))
  
  # Compute annual average precipitation
  
  nyear <- ndays / 365
  
  annual_prec <- pr_acc / nyear
  
  # Write data frame with annual precipitation
  
  df_output <- data.frame(id_bil = id_bil_file - 1,
                          lat = lat,
                          lon = lon,
                          annual_prec = annual_prec)
  
  filename <- file.path(path_sim, "annual_prec.txt")
  
  write.table(df_output, file = filename, quote = FALSE, sep = ";", row.names = FALSE)
  
  # Write data frame with missing files
  
  df_output <- data.frame(missing_files = missing_files)
  
  filename <- file.path(path_sim, "missing_files.txt")
  
  write.table(df_output, file = filename, quote = FALSE, sep = ";", row.names = FALSE)
  
  # Write dates to file
  
  time_meteodata <- seq(ISOdate(syear,1,1,6,0,0),ISOdate(eyear,12,31,6,0,0), by = "days")
  
  df_output <- data.frame(times = time_meteodata)
  
  filename <- file.path(path_sim, "time_meteodata.txt")
  
  write.table(df_output, file = filename, quote = FALSE, sep = ";", row.names = FALSE)
  
}


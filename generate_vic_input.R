
#########################################################################################################

# Start and end years

syear <- 1991
eyear <- 1991

scale <- 10

# Paths to meteorological data

path_prec_bil <- "//hdata/grid/metdata/met_obs_v2.1/rr"
path_tmin_bil <- "//hdata/grid/metdata/met_obs_v2.1/tm"
path_tmax_bil <- "//hdata/grid/metdata/met_obs_v2.1/tm"
path_wind_bil <- "//hdata/grid2/metdata/klinogrid/ffm24h06"

# Path for storing the results

path_results <- "//unixhome/users/jmg/Projects/VIC_MTCLIM/test_real/forcing"


#########################################################################################################

# Delete all files in the "path_results" folder

dummy <- file.remove(file.path(path_results,list.files(path_results)))

# Names for vic input files (coordinates from InnaforNorge.txt)

df_in_norway <- read.csv("InnenforNorge.txt", header = TRUE, sep = ";")

fn_vic_input <- vector(mode = "character", length = nrow(df_in_norway))
id_bil_file <- vector(mode = "numeric", length = nrow(df_in_norway))

for (irow in 1:nrow(df_in_norway)) {
  
  id_bil_file[irow] <- df_in_norway$TABID[irow]+1
  
  lat <- format(df_in_norway$POINT_Y[irow], nsmall = 5, digits = 5)
  lon <- format(df_in_norway$POINT_X[irow], nsmall = 5, digits = 5)
  
  file_tmp <- paste("data", lat, lon, sep = "_")
  
  fn_vic_input[irow] <- file.path(path_results, file_tmp)
  
}

# Loop over years

nyear <- length(syear:eyear)

for ( i in syear:eyear) {
  
  days <- seq(ISOdate(i,1,1),ISOdate(i ,12,31),"day")
  ndays <- length(days)
  s1 <- as.POSIXlt(days)$year+1900
  s2 <- as.POSIXlt(days)$mon+1
  s3 <- as.POSIXlt(days)$mday
  
  # Loop over months
  
  for ( m in 1:1) {   ###12) { #### *** #########################################################################
    
    mstart <- min(which(s2==m))
    mend <- max(which(s2==m))
    
    # Loop over days
    
    for ( j in mstart:mend) {
      
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
      
      filename <- paste(path_tmax_bil,"/",i,"/tm_",time_name,sep="")
      indata <- file(filename,"rb")
      run <- readBin(indata, integer(), n=1195*1550, size=2)   # for temperature
      #str(run)
      close(indata)
      
      tmax <- (run[id_bil_file]-2731)/scale   +   3  ##############  HACK
      
      #tmin
      
      filename <- paste(path_tmin_bil,"/",i,"/tm_",time_name,sep="")
      indata <- file(filename,"rb")
      run <- readBin(indata, integer(), n=1195*1550, size=2)   # for temperature
      #str(run)
      close(indata)
      
      tmin <- (run[id_bil_file]-2731)/scale   -   3  ##############  HACK
      
      # prcp
      
      filename <- paste(path_prec_bil,"/",i,"/rr_",time_name,sep="")
      indata <- file(filename,"rb")
      run <- readBin(indata, integer(), n=1195*1550, size=2)   # for precipitation
      #str(run)
      close(indata)
      
      pr <- run[id_bil_file]/scale
      
      # wind
      
      filename <- paste(path_wind_bil,"/",i,"/ffm24h06_",time_name,sep="")
      indata <- file(filename,"rb")
      run <- readBin(indata, integer(), n=1195*1550, size=2)   # for wind
      #str(run)
      close(indata)
      
      wind <- run[id_bil_file]/scale
      
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
      
      if(j==mstart) {
        data_all <- pr
        data_all <- rbind(data_all, tmin)
        data_all <- rbind(data_all, tmax)
        data_all <- rbind(data_all, wind)
      } else {
        data_all <- rbind(data_all, pr)
        data_all <- rbind(data_all, tmin)
        data_all <- rbind(data_all, tmax)
        data_all <- rbind(data_all, wind)
      }
      
    }  # end j
    
    print(time_name)
    
  } # end m
  
  # Write data to binary files for VIC
  
  for (nfile in 1:10) {     ### length(id_bil_file)) {   ### *** #########################################
    
    # Open vic input files for writing
    
    file_vic <- file(fn_vic_input[nfile], "ab")
    
    # Convert to integer and append to file
    
    for (irow in 1:nrow(data_all)) {
    
      data_vec <- as.integer(data_all[irow, nfile] * 100)
      
      writeBin(data_vec, file_vic, endian = "little", size = 2)
      
      print(irow)
      
    }
    
    
    # Close connection
    
    close(file_vic)
    
  }
  
} # end i




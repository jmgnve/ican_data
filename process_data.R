# years
syear <- 1991
eyear <- 1991

scale <- 10


# Paths to inputs and outputs

path_prec_bil <- "dummy"
path_tmin_bil <- "dummy"
path_tmax_bil <- "dummy"
path_wind_bil <- "dummy"

path_results <- "test_data"

# Source required files

source("vic_data_handling.R")






# Names for vic input files (coordinates from InnaforNorge.txt)  JMG

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

########## LOOP year
nyear <- length(syear:eyear)

for ( i in syear:eyear) {

days <- seq(ISOdate(i,1,1),ISOdate(i ,12,31),"day")
ndays <- length(days)
s1 <- as.POSIXlt(days)$year+1900
s2 <-   as.POSIXlt(days)$mon+1
s3 <-   as.POSIXlt(days)$mday

###### loop monthly
  for ( m in 1:12) {
    mstart <- min(which(s2==m))
    mend <- max(which(s2==m))

###### loop For each day, open bil files for wind, prec, tmin and tmax   SHH
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
       
   tmax <- (run[id_bil_file]-2731)/scale

#tmin

     filename <- paste(path_tmin_bil,"/",i,"/tm_",time_name,sep="")
      indata <- file(filename,"rb")
       run <- readBin(indata, integer(), n=1195*1550, size=2)   # for temperature
       #str(run)
     close(indata)

   tmin <- (run[id_bil_file]-2731)/scale

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
	
###### Correct precipitation    SHH
Tmean <- (tmax+tmin)/2
Windspeed_at_gauge <- (log(1/0.03)/log(10/0.03))*wind 
Windspeed_at_gauge[which(Windspeed_at_gauge>6.5)] <- 6.5

select <- which(Tmean< (-1.5))
pr[select] <- pr[select]*(1/((100-11.95*Windspeed_at_gauge[select]+Windspeed_at_gauge[select]*Windspeed_at_gauge[select]*0.55)/100))

select <- which(Tmean>= (-1.5)&Tmean <0.5)
pr[select] <- pr[select]*(1/((100-8.16*Windspeed_at_gauge[select]+Windspeed_at_gauge[select]*Windspeed_at_gauge[select]*0.45)/100))

select <- which(Tmean>=0.5)
pr[select] <- pr[select]*(1/((100-3.37*Windspeed_at_gauge[select]+Windspeed_at_gauge[select]*Windspeed_at_gauge[select]*0.35)/100))


 # save the daily outputs
if(j==mstart) {
tmax_all <- tmax
tmin_all <- tmin
pr_all <- pr
wind_all <- wind
} else {
tmax_all <- rbind(tmax_all,tmax)
tmin_all <- rbind(tmin_all,tmin)
pr_all <- rbind(pr_all,pr)
wind_all <- rbind(wind_all,wind)
}

 }  # end j
 
 print(time_name)

 ####### just an example how to write the  monthly results
  if(m==1&i==syear) {
  for (nfile in 1:324567) {
  out <- cbind(mstart:mend, tmax_all[,nfile],tmin_all[,nfile],pr_all[,nfile],wind_all[,nfile])
  colnames(out) <- c("yearday","tmax","tmin","prcp","wind")
  write.table(out,paste(save_directory,nfile,".txt",sep=""),
append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = F,
            col.names = TRUE)
    } # end nfile
  } else {

  for (nfile in 1:324567) {
  out <- cbind(mstart:mend, tmax_all[,nfile],tmin_all[,nfile],pr_all[,nfile],wind_all[,nfile])
  write.table(out,paste(save_directory,nfile,".txt",sep=""),
append = TRUE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = F,
            col.names = F)
    } # end nfile
   } # endif
   
   

} # end m
  
} # end i
  
  
  
  
  # Loop over grid cells
  
  for (ifile in 1:length(fn_vic_input)) {
    
    # Open vic input files for writing
    
    file_vic <- file(fn_vic_input[ifile], "ab")
    
    # Add dummy data
    
    prec <- 10
    tmin <- 5
    tmax <- 10
    wind <- 10
    
    write_met_input(file_vic, prec, tmin, tmax, wind)
    
    close(file_vic)
    
  }
  
}














########## LOOP

# Happy









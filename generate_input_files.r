####################input

work_directory <- "D:/projects/Common_Data/WFDEI/data/binary/"
save_directory <- "D:/projects/Common_Data/WFDEI/data/mtclim/"

syear <- 1991
eyear <- 2000

scale <- 10

######################
setwd(work_directory)

nyear <- length(syear:eyear)

for ( i in syear:eyear) {

days <- seq(ISOdate(i,1,1),ISOdate(i ,12,31),"day")
ndays <- length(days)
s1 <- as.POSIXlt(days)$year+1900
s2 <-   as.POSIXlt(days)$mon+1
s3 <-   as.POSIXlt(days)$mday

  for ( m in 1:12) {
    mstart <- min(which(s2==m))
    mend <- max(which(s2==m))

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

     filename <- paste("tmax/",i,"/tmax_",time_name,sep="")
      indata <- file(filename,"rb")
       run <- readBin(indata, integer(), n=324567, size=2)   # for temperature
       #str(run)
     close(indata)

   tmax <- (run-2731)/scale

#tmin

     filename <- paste("tmin/",i,"/tmin_",time_name,sep="")
      indata <- file(filename,"rb")
       run <- readBin(indata, integer(), n=324567, size=2)   # for temperature
       #str(run)
     close(indata)

   tmin <- (run-2731)/scale

# prcp

     filename <- paste("rr/",i,"/rr_",time_name,sep="")
      indata <- file(filename,"rb")
       run <- readBin(indata, integer(), n=324567, size=2)   # for temperature
       #str(run)
    close(indata)

   pr <- run/scale

# wind

     filename <- paste("wind/",i,"/wind_",time_name,sep="")
      indata <- file(filename,"rb")
       run <- readBin(indata, integer(), n=324567, size=2)   # for temperature
       #str(run)
    close(indata)
  
    wind <- run/scale

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


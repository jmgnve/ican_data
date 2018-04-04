

write_bin <- function(directory, variable, syear, eyear) {
nyear <- length(syear:eyear)

days <- seq(ISOdate(syear,1,1),ISOdate(eyear,12,31),"day")
ndays <- length(days)
s1 <- as.POSIXlt(days)$year+1900
s2 <-   as.POSIXlt(days)$mon+1
s3 <-   as.POSIXlt(days)$mday

data <- read.table(paste(directory,variable,"_",syear,"_",eyear,".txt",sep=""),header=F)
str(data)

 for ( j in 1:ndays) {

if(s2[j]==1&s3[j]==1) {
system(paste("mkdir",paste(directory,variable,"/",s1[j],sep="")))
}


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



out <- as.integer(data[,j])


filename <- paste(directory,variable,"/",s1[j],"/",variable,"_",time_name,sep="")
      indata <- file(filename,"wb")
writeBin(out, filename,size = 2)   #,size = 2
close(indata)


} # end j

}   # end function
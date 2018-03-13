

zz <- "rr"
  
# Paths to meteorological data
  
  zz1 <- zz


path_prec_bil <- paste("/hdata/grid/metdata/met_obs_v2.1/",zz1,sep="")
                       


# Path for storing the results

path_met <- paste("/data02/Ican/vic_sim/past_1km/bil/",zz,sep="")



df_in_norway <- read.csv("/data02/Ican/hbv/troendelag2/InnenforNorge_2017_new.txt", header = TRUE, sep = ";")
str(df_in_norway)



id <- df_in_norway[,2]+1


syear <- 1982
eyear <- 1999

# Loop over years


nyear <- length(syear:eyear)


for ( i in syear:eyear) {
  
  days <- seq(ISOdate(i,1,1),ISOdate(i ,12,31),"day")
  s1 <- as.POSIXlt(days)$year+1900
  s2 <- as.POSIXlt(days)$mon+1
  s3 <- as.POSIXlt(days)$mday
  
  # Allocate output array
  
  
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
    
    
    
    # prcp
    
    filename <- paste(path_prec_bil,"/",i,"/",zz,"_",time_name,sep="")
    
    
    
    indata <- file(filename,"rb")
    run <- readBin(indata, integer(), n=1195*1550, size=2)   # for precipitation
    close(indata)
    
    pr <- run[id]
    
    #out <- as.integer(data[,j])
    
 #   if(s2[j]==1&s3[j]==1) {
 #     system(paste("mkdir",paste(path_met,"/",s1[j],sep="")))
 #   }
    filename <- paste(path_met,"/",s1[j],"/",zz,"_",time_name,sep="")
    indata <- file(filename,"wb")
    writeBin(pr, filename,size = 2)   #,size = 2
    close(indata)
    
  } # end j
} #end i


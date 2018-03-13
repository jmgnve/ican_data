       
source("/home/shh/project/Ican/Github/ican_data/vic_reading_files.R")

path_sim = "/data02/Ican/vic_sim/past_1km"

path_result <- "/data02/Ican/vic_sim/past_1km/bil/"


file_id <- read.table("/home/shh/project/Ican/Github/ican_data/InnenforNorge_2017.txt", header=T,sep=";")
n_id <- length(file_id[,1])

syear <- 1982
eyear <- 2012

out_syear <- 2003
out_eyear <- 2012

# Read output

    days <- seq(ISOdate(syear,1,1),ISOdate(eyear,12,31),"day")
    s1 <- as.POSIXlt(days)$year+1900
    selec <- which(s1>=out_syear&s1<=out_eyear)


for ( i in 1:n_id) {

    lat <- format(file_id$POINT_Y[i], nsmall = 5, digits = 5)
    lon <- format(file_id$POINT_X[i], nsmall = 5, digits = 5)

file <- paste(path_sim,"/results/metdata_",lat, "_", lon, sep="")


data <- read_met_output(file,40)

tm <- round((data$tair[selec]*10 + 2731), 0)
rr <- round(data$prec[selec]*10,0)
wind <- round(data$wind[selec]*10,0)
srad <- round(data$iswr[selec]*0.0864 *10,0)  # convert from w/m2 to MJ/m2/day
vp <- round(data$vp[selec]*1000*10,0)         # convert from kPa to Pa


 if(i==1) {
   write.table(t(vp), paste(path_result,"vp_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = FALSE)
   write.table(t(srad),paste(path_result,"srad_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = FALSE)
            
  write.table(t(tm), paste(path_result,"tm_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = FALSE)
   write.table(t(rr),paste(path_result,"rr_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = FALSE)
  write.table(t(wind),paste(path_result,"wind_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = FALSE)
   } else {
   write.table(t(vp), paste(path_result,"vp_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = TRUE)
   write.table(t(srad),paste(path_result,"srad_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = TRUE)
            
  write.table(t(tm), paste(path_result,"tm_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = TRUE)
   write.table(t(rr),paste(path_result,"rr_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = TRUE)
  write.table(t(wind),paste(path_result,"wind_",out_syear,"_",out_eyear,".txt",sep=""),row.names = FALSE,
            col.names = FALSE,append = TRUE)
    }

    print(i)

}
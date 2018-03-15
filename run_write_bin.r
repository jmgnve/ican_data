source("/home/shh/project/Ican/Github/ican_data/write_bin.r")

directory <- "/data02/Ican/vic_sim/past_1km/bil/"

variable <- "srad"
#system(paste("mkdir",paste(directory,variable,sep="")))

write_bin(directory, variable, 1982, 1992)
write_bin(directory, variable, 1993, 2002)
write_bin(directory, variable, 2003, 2012)


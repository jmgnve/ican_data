########################################################################

source("vic_data_handling.R")


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

# src/./vicNl -g test_iha/params/global_param



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









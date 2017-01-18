########################################################################

source("vic_data_handling.R")


# Read output

filename <- "//unixhome/users/jmg/Projects/VIC_MTCLIM/test_real/results/jan_full_data_57.98290_7.04963"

data_jan <- read_met_output(filename)


# Plot results

plot(data_jan$prec, type = "l", ylab = "Precipitation")

plot(data_jan$tair, type = "l", ylab = "Air temperature")

plot(data_jan$iswr, type = "l", ylab = "Shortwave radiation")

plot(data_jan$ilwr, type = "l", ylab = "Longwave radiation")

plot(data_jan$pres, type = "l", ylab = "Air pressure")

plot(data_jan$qair, type = "l", ylab = "Specific humidity?")

plot(data_jan$vp, type = "l", ylab = "Vapor pressure")









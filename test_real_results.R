########################################################################

source("vic_reading_files.R")


# Read output

filename <- "/data02/Ican/vic_sim/past_1km/results/jan_full_data_71.13016_27.64479"

data_jan <- read_met_output(filename)


# Plot results

plot(data_jan$prec, type = "l", ylab = "Precipitation")

plot(data_jan$tair, type = "l", ylab = "Air temperature")

plot(data_jan$iswr, type = "l", ylab = "Shortwave radiation")

plot(data_jan$ilwr, type = "l", ylab = "Longwave radiation")

plot(data_jan$pres, type = "l", ylab = "Air pressure")

plot(data_jan$qair, type = "l", ylab = "Specific humidity?")

plot(data_jan$vp, type = "l", ylab = "Vapor pressure")

plot(data_jan$wind, type = "l", ylab = "Wind")







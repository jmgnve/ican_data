########################################################################

source("vic_reading_files.R")


# Read output

ifile = 100

path_sim = "/data02/Ican/vic_sim/past_1km"

filenames <- list.files(file.path(path_sim, "results"))

data_jan <- read_met_output(file.path(path_sim, "results", filenames[ifile]))


# Plot results

X11()
plot(data_jan$prec, type = "l", ylab = "Precipitation")

X11()
plot(data_jan$tair, type = "l", ylab = "Air temperature")

X11()
plot(data_jan$iswr, type = "l", ylab = "Shortwave radiation")

X11()
plot(data_jan$ilwr, type = "l", ylab = "Longwave radiation")

X11()
plot(data_jan$pres, type = "l", ylab = "Air pressure")

X11()
plot(data_jan$qair, type = "l", ylab = "Specific humidity?")

X11()
plot(data_jan$vp, type = "l", ylab = "Vapor pressure")

X11()
plot(data_jan$wind, type = "l", ylab = "Wind")







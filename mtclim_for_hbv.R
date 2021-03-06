


#############################################################################

# Clear workspace

rm(list=ls())

# Input for past climate

source("vic_meteo_input.R")
source("vic_soil_params.R")
source("vic_veg_params.R")
source("vic_veglib_params.R")
source("vic_global_params.R")

# Start and end year for model input

syear <- 1982
eyear <- 2012

# Path for output

path_sim <- "/data02/Ican/vic_sim/past_1km"

# Write forcing data

write_met_input(path_sim, syear, eyear)

# Write soil parameters

write_soil_params(path_sim)

# Write vegetation parameters

write_veg_params(path_sim)

# Write vegetation library file

write_veglib_params(path_sim)

# Write global parameter file

write_global_param(path_sim, syear, eyear)

# Run VIC-MTCLIM

system("/home/jmg/projects/vic_mtclim/src/./vicNl -g /data02/Ican/vic_sim/past_1km/params/global_param")



#############################################################################

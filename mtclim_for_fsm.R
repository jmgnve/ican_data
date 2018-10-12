

# Clear workspace

rm(list=ls())

# Input for past climate

source("vic_meteo_input.R")
source("vic_soil_params.R")
source("vic_veg_params.R")
source("vic_veglib_params.R")
source("vic_global_params.R")
source("run_mtclim.R")

# Settings

syear <- 2008
eyear <- 2011
timestep <- 3
model <- "fsm"
climate_model <- "obs"
scenario <- "dummy"
output_force <- TRUE

# Path for output

path_sim <- "/data02/Ican/vic_sim/fsm_past_test"

# Create paths

dir.create(file.path(path_sim, "forcing"))
dir.create(file.path(path_sim, "results"))

# Write forcing data

write_met_input(path_sim, syear, eyear, model, climate_model, scenario)

# Run mtclim

run_vic(syear, eyear, timestep, model, path_sim, output_force)





# Clear workspace

rm(list=ls())


# Source scripts

source("vic_meteo_input.R")
source("vic_soil_params.R")
source("vic_veg_params.R")
source("vic_veglib_params.R")
source("vic_global_params.R")


# Function for running mtclim for one set of inputs

run_mtclim <- function(syear, eyear, timestep, model, path_sim) {

  # Create paths

  dir.create(file.path(path_sim, "forcing"))
  dir.create(file.path(path_sim, "results"))

  # Write forcing data

  write_met_input(path_sim, syear, eyear)

  # Write soil parameters

  write_soil_params(path_sim)

  # Write vegetation parameters

  write_veg_params(path_sim)

  # Write vegetation library file

  write_veglib_params(path_sim)

  # Write global parameter file

  write_global_param(path_sim, syear, eyear, timestep = timestep, model = model)

  # Run VIC-MTCLIM

  system(paste("/home/jmg/projects/vic_mtclim/src/./vicNl -g ", path_sim, "/params/global_param", sep = ""))
    
}






# Run mtclim for fsm

syear <- 2002
eyear <- 2005
timestep <- 3
model <- "fsm"

run_mtclim <- function(syear, eyear, timestep, model, path_sim)

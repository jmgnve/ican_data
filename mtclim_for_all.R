

# Clear workspace

rm(list=ls())


# Source scripts

source("vic_meteo_input.R")
source("vic_soil_params.R")
source("vic_veg_params.R")
source("vic_veglib_params.R")
source("vic_global_params.R")
source("run_mtclim.R")

# inputs
syear <- 2006
eyear <- 2100

model <- "hbv"
climate_model <- "IPSL-CM5A_SMHI-RCA4"      # or "obs"
scenario <- "rcp45"
timestep <- 24

path <- "/data02/Ican/vic_sim/hbv"

output_force <- TRUE


# Create paths

  system(paste("mkdir ", path,"/",climate_model,sep=""))
  if(scenario!="") {
  system(paste("mkdir ", path,"/",climate_model,"/",scenario,sep=""))
  }
  
  path_sim <- paste(path,"/",climate_model,"/",scenario,sep="")
  
  dir.create(file.path(path_sim, "forcing"))
  dir.create(file.path(path_sim, "results"))
  
# run mtclim and vic

write_met_input(path_sim, syear, eyear,model, climate_model,scenario)
run_vic(syear, eyear, timestep, model, path_sim,output_force)


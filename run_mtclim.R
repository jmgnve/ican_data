# Function for running mtclim for one set of inputs

run_vic <- function(syear, eyear, timestep, model, path_sim,output_force) {
# Write soil parameters

  write_soil_params(path_sim)

  # Write vegetation parameters

  write_veg_params(path_sim)

  # Write vegetation library file

  write_veglib_params(path_sim)

  # Write global parameter file

  write_global_param(path_sim, syear, eyear, timestep = timestep, output_force, model = model)

  # Run VIC-MTCLIM

  system(paste("/felles/jmg/VIC.4.2.d/src/./vicNl -g ", path_sim, "/params/global_param", sep = ""))
  }
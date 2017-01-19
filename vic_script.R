


#############################################################################

# Input for past climate

# Start and end year for model input

syear <- 1991
eyear <- 1991

# Path for output

path_sim <- "//unixhome/users/jmg/projects/vic_mtclim/test_real"

# Write forcing data

write_met_input(path_sim, syear, eyear)

# Write soil parameters

write_soil_params(path_sim)

# Write vegetation parameters

write_veg_params(path_sim)

#############################################################################

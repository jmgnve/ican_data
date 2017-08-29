###############################################################################

# Select watershed by drainage basin key

dbk = "1445"

# Select start and end year for simulation

syear <- 1982

eyear <- 2012

# Simulation time step

timestep = 3

# Run forcing mode

output_force = TRUE

# Folder containing base VIC setup and input data

base_folder = "/data02/Ican/vic_sim/past_1km"

# Folder where to store new results

target_folder = "/data02/Ican/vic_sim/past_gaulfoss"

###############################################################################

# Source external files

source("read_index_file.R")
source("vic_soil_params.R")
source("vic_global_params.R")

# Read index file

wsh_index = read_index_file("SeNorge.txt")

# Create folder and copy data from base folder

dir.create(file.path(target_folder, "params"), showWarnings = FALSE)
dir.create(file.path(target_folder, "forcing"), showWarnings = FALSE)
dir.create(file.path(target_folder, "results"), showWarnings = FALSE)

# Copy all parameter files from base to target

file.copy(file.path(base_folder, "params"), file.path(target_folder), recursive = TRUE, overwrite = TRUE)

# Read soil parameter file

col_names <- c("run_cell", "gridcel", "lat", "lon", "infilt", "D1", "D2", "D3", "D4",
               "expt1", "expt2", "expt3", "Ksat1", "Ksat2", "Ksat3", "phi_s1", "phi_s2",
               "phi_s3", "init_moist1", "init_moist2", "init_moist3", "elev", "depth1",
               "depth2", "depth3", "avg_T","dp", "bubble1", "bubble2", "bubble3", "quartz1",
               "quartz2", "quartz3", "bulk_density1", "bulk_density2", "bulk_density3",
               "soil_density1", "soil_density2", "soil_density3", "off_gmt", "Wcr_FRACT1",
               "Wcr_FRACT2", "Wcr_FRACT3", "Wpwp_FRACT1", "Wpwp_FRACT2", "Wpwp_FRACT3",
               "rough", "snow_rough", "annual_prec", "resid_moist1", "resid_moist2",
               "resid_moist3", "fs_active", "na")

soil_params <- read.delim(file = file.path(base_folder, "params/soil_param"), sep = " ", 
                          header = FALSE, strip.white = TRUE, col.names = col_names)

# Select rows to keep

ikeep <- which(soil_params$gridcel %in% wsh_index[[dbk]])

soil_params <- soil_params[ikeep, ]

# Save new soil parameter file

for (irow in 1:nrow(soil_params)) {
  
  # Append data to file
  
  if (irow == 1) {
    append_soil_file(target_folder, soil_params[irow, ], TRUE)
  } else {
    append_soil_file(target_folder, soil_params[irow, ], FALSE)
  }
  
}

# Write new global parameter file

write_global_param(target_folder, syear, eyear, timestep = timestep, output_force = output_force)

# Copy necessary forcing files

for (irow in 1:nrow(soil_params)) {
  
  lat <- format(soil_params$lat[irow], nsmall = 5, digits = 5)
  lon <- format(soil_params$lon[irow], nsmall = 5, digits = 5)
  
  filename <- paste("data", lat, lon, sep = "_")  
  
  file.copy(from = file.path(base_folder, "forcing", filename),
            to = file.path(target_folder, "forcing", filename), overwrite = TRUE)
  
}

# Run VIC-MTCLIM

start_time <- Sys.time()

system(paste("/home/jmg/projects/vic_mtclim/src/./vicNl -g ", file.path(target_folder, "params/global_param"), sep = ""))

end_time <- Sys.time()

time_taken <- end_time - start_time

print("Total execution time:")

time_taken

print("Execution time per grid point:")

time_taken/nrow(soil_params)









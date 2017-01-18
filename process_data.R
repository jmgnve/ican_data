


# Paths to inputs and outputs

path_prec_bil <- "dummy"
path_tmin_bil <- "dummy"
path_tmax_bil <- "dummy"
path_wind_bil <- "dummy"

path_results <- "test_data"

# Source required files

source("vic_data_handling.R")






# Names for vic input files (coordinates from InnaforNorge.txt)  JMG

df_in_norway <- read.csv("InnenforNorge.txt", header = TRUE, sep = ";")

fn_vic_input <- vector(mode = "character", length = nrow(df_in_norway))
id_bil_file <- vector(mode = "numeric", length = nrow(df_in_norway))

for (irow in 1:nrow(df_in_norway)) {
  
  id_bil_file[irow] <- df_in_norway$TABID[irow]
  
  lat <- format(df_in_norway$POINT_Y[irow], nsmall = 5, digits = 5)
  lon <- format(df_in_norway$POINT_X[irow], nsmall = 5, digits = 5)
  
  file_tmp <- paste("data", lat, lon, sep = "_")
  
  fn_vic_input[irow] <- file.path(path_results, file_tmp)
  
}

# Loop over days with input data

for (itime in 1:10) {
  
  print(itime)
  
  # Process minimal air temperature data
  
  
  
  
  # Process maximum air temperature data
  
  
  
  
  # Process wind speed data
  
  
  
  
  
  # Process precipitation data
  
  
  
  
  
  
  
  # Loop over grid cells
  
  for (ifile in 1:length(fn_vic_input)) {
    
    # Open vic input files for writing
    
    file_vic <- file(fn_vic_input[ifile], "ab")
    
    # Add dummy data
    
    prec <- 10
    tmin <- 5
    tmax <- 10
    wind <- 10
    
    write_met_input(file_vic, prec, tmin, tmax, wind)
    
    close(file_vic)
    
  }
  
}













########## LOOP

# For each day, open bil files for wind, prec, tmin and tmax   SHH




# Correct precipitation    SHH




# Append wind, prec, tmin and tmax to vic input files    SHH/JAN





########## LOOP

# Happy









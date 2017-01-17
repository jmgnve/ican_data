


# Paths to inputs and outputs

path_prec_bil <- "dummy"
path_tmin_bil <- "dummy"
path_tmax_bil <- "dummy"
path_wind_bil <- "dummy"


# Source required files

source("vic_data_handling.R")






# Names for vic input files (coordinates from InnaforNorge.txt)  JMG

df_in_norway <- read.csv("InnenforNorge.txt", header = TRUE, sep = ";")

fn_vic_input <- vector(mode = "character", length = nrow(df_in_norway))
id_bil_file <- vector(mode = "numeric", length = nrow(df_in_norway))

for (irow in 1:nrow(df_in_norway)) {
  
  id_bil_file[irow] <- df_in_norway$TABID[irow]
  
  x_coord <- format(df_in_norway$POINT_X[irow], nsmall = 5, digits = 5)
  y_coord <- format(df_in_norway$POINT_Y[irow], nsmall = 5, digits = 5)
  
  fn_vic_input[irow] <- paste("data", x_coord, y_coord, sep = "_")
  
}

# Open the vic files for writing + appending


########## LOOP

# For each day, open bil files for wind, prec, tmin and tmax   SHH




# Correct precipitation    SHH




# Append wind, prec, tmin and tmax to vic input files    SHH/JAN





########## LOOP

# Happy









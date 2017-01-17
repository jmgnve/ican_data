


# Paths to inputs and outputs

path_prec_bil <- "dummy"
path_tmin_bil <- "dummy"
path_tmax_bil <- "dummy"
path_wind_bil <- "dummy"


# Source required files








# Names for vic input files (coordinates from InnaforNorge.txt)  JMG

df_in_norway <- data.frame(lat = c(456,654),
                           lon = c(456,872))

fn_vic_input <- c()

for (irow in 1:nrow(df_in_norway)) {
  
  fn_vic_input[irow] <- paste("data", df_in_norway$lat[irow], df_in_norway$lon[irow], sep = "_")
  
}




# Open the vic files for writing + appending


########## LOOP

# For each day, open bil files for wind, prec, tmin and tmax   SHH




# Correct precipitation    SHH




# Append wind, prec, tmin and tmax to vic input files    SHH/JAN





########## LOOP

# Happy









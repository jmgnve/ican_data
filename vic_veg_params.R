#########################################################################################################

# List of vegetation parameters needed for vic.4.2.d (for each grid cell)
# http://vic.readthedocs.io/en/vic.4.2.d/Documentation/VegParam/
# There are more options than listed below.

# For each grid cell:
#
# gridcel - Identifier (jmg: clear what this should be)
# Nveg - Number of vegetation classes (jmg: either from global or local info)
#
# Repeats for each vegetation tile in the grid cell:
#
# veg_class - Vegetation class defined in "Vegetation Library File"
# Cv - Fraction of grid cell covered by vegetation tile (jmg: either from global or local info)
#
# For each vegetation tile, repeats for each defined root zone:
#
# root_depth - Root zone thickness (jmg: either from global or local info)
# root_fract - Fraction of root in the current root zone (jmg: either from global or local info)
#
# Optional (if VEGPARAM_LAI == TRUE in global parameter file):
#
# LAI - Leaf Area Index, one per month (jmg: either from global or local info)




#########################################################################################################

write_veg_params <- function(path_sim) {
  
  # Read InnenforNorge
  
  col_names = c("na", "bil_id", "lon", "lat", "elev")
  
  df_norway <- read.csv("InnenforNorge.txt", header = TRUE, sep = ";", col.names = col_names)
  
  # Write dummy vegetation parameters
  
  file_veg <- file.path(path_sim, "params/veg_param")
  
  for (irow in 1:nrow(df_norway)) {
    
    gridcel <- df_norway$bil_id[irow]
    ntiles  <- 2
    
    header <- paste(gridcel, ntiles, "\n", sep = " ")
    
    if (irow == 1) {
      cat(sprintf(header), file = file_veg, append = FALSE)
    } else {
      cat(sprintf(header), file = file_veg, append = TRUE)
    }
    
    cat(sprintf("     8 0.102679 0.10 0.10 1.00 0.65 0.50 0.25\n"), file = file_veg, append = TRUE)
    cat(sprintf("       0.312 0.413 0.413 0.413 0.413 0.488 0.975 1.150 0.625 0.312 0.312 0.312\n"), file = file_veg, append = TRUE)
    cat(sprintf("    10 0.897321 0.10 0.10 1.00 0.70 0.50 0.20\n"), file = file_veg, append = TRUE)
    cat(sprintf("       0.212 0.262 0.275 0.338 0.750 1.275 0.950 0.650 0.450 0.288 0.237 0.212\n"), file = file_veg, append = TRUE)
    
    # Write progress
    
    if (irow%%1000 == 0) {
      print(paste("Vegetation param. Wrote line: ", irow, sep = ""))
    }
    
  }
  
}










# con <- file("vic_params_global/global_veg_param_new", "r")
# 
# header <- 999
# 
# while (length(header) > 0) {
#   
#   header <- readLines(con, n = 1)
#   
#   header <- strsplit(header, " ")
#   
#   gridcel <- as.numeric(header[[1]][1])
#   ntiles <- as.numeric(header[[1]][2])
#   
#   veg_info <- c()
#   
#   if (ntiles>0) {
#     
#     for (irow in 1:(2*ntiles)) {
#       
#       
#       
#       
#     }
#     
#   }
#   
# }
# 
# close(con)
# 


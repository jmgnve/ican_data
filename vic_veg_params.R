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
    ntiles  <- 3
    
    header <- paste(gridcel, ntiles, "\n", sep = " ")
    
    if (irow == 1) {
      cat(sprintf(header), file = file_veg, append = FALSE)
    } else {
      cat(sprintf(header), file = file_veg, append = TRUE)
    }
    
    cat(sprintf("     7 0.107 0.30 0.60 0.70 0.40\n"), file = file_veg, append = TRUE)
    cat(sprintf("       0.837 1.500 2.037 2.975 3.675 3.512 3.375 3.087 3.138 2.312 1.450 0.800\n"), file = file_veg, append = TRUE)
    cat(sprintf("    10 0.772 0.30 0.80 0.70 0.20\n"), file = file_veg, append = TRUE)
    cat(sprintf("       0.237 0.287 0.400 0.600 0.837 1.000 0.625 0.450 0.338 0.300 0.262 0.212\n"), file = file_veg, append = TRUE)
    cat(sprintf("    11 0.121 0.30 0.50 0.70 0.50\n"), file = file_veg, append = TRUE)
    cat(sprintf("       0.148 0.349 0.732 1.237 1.110 0.887 1.459 1.549 0.782 0.305 0.135 0.100\n"), file = file_veg, append = TRUE)
    
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


#########################################################################################################

# List of soil parameters needed for vic.4.2.d 
# http://vic.readthedocs.io/en/vic.4.2.d/Documentation/SoilParam/

# 1:  run_cell - Run cell or not (jmg: clear what this should be)
# 2:  gridcel - Identifier (jmg: clear what this should be)
# 3:  lat - Latitude (jmg: clear what this should be)
# 4:  lon - Longitude (jmg: clear what this should be)
# 5:  infilt - Variable infiltration curve parameter (jmg: from global file or calibration)
# 6:  D1 - Fraction of Dsmax where non-linear baseflow begins (jmg: from global file or calibration)
# 7:  D2 - Maximum velocity of baseflow (jmg: from global file or calibration)
# 8:  D3 - Fraction of maximum soil moisture where non-linear baseflow occurs (jmg: from global file or calibration)
# 9:  D4 - Exponent used in baseflow curve, normally set to 2 (jmg: from global file or calibration)
# 10: expt1 - Exponent in Campbell's eqn for hydraulic conductivity (jmg: from global file or calibration)
# 11: expt2 - Exponent in Campbell's eqn for hydraulic conductivity (jmg: from global file or calibration)
# 12: expt3 - Exponent in Campbell's eqn for hydraulic conductivity (jmg: from global file or calibration)
# 13: Ksat1 - Saturated hydrologic conductivity (jmg: from global file, local data or calibration)
# 14: Ksat2 - Saturated hydrologic conductivity (jmg: from global file, local data or calibration)
# 15: Ksat3 - Saturated hydrologic conductivity (jmg: from global file, local data or calibration)
# 16: phi_s1 - Soil moisture diffusion parameter (jmg: from global file, local data or calibration)
# 17: phi_s2 - Soil moisture diffusion parameter (jmg: from global file, local data or calibration)
# 18: phi_s3 - Soil moisture diffusion parameter (jmg: from global file, local data or calibration)
# 19: init_moist1 - Initial layer moisture content (jmg: from global file)
# 20: init_moist2 -	Initial layer moisture content (jmg: from global file)
# 21: init_moist3 - Initial layer moisture content (jmg: from global file)
# 22: elev - Average elevation of grid cell (jmg: from dem)
# 23: depth1 - Thickness of each soil moisture layer (jmg: from global file or local data)
# 24: depth2 - Thickness of each soil moisture layer (jmg: from global file or local data)
# 25: depth3 - Thickness of each soil moisture layer (jmg: from global file or local data)
# 26: avg_T - Average soil temperature, used as the bottom boundary for soil heat flux solutions (jmg: from global file or local assumption)
# 27: dp - Soil thermal damping depth (jmg: from global file or local assumption)
# 28: bubble1 - Bubbling pressure of soil (jmg: not relevant I think)
# 29: bubble2 - Bubbling pressure of soil (jmg: not relevant I think)
# 30: bubble3 - Bubbling pressure of soil (jmg: not relevant I think)
# 31: quartz1 - Quartz content of soil (jmg: not relevant I think)
# 32: quartz2 -	Quartz content of soil  (jmg: not relevant I think)
# 33: quartz3 -	Quartz content of soil  (jmg: not relevant I think)
# 34: bulk_density1 - Bulk density of soil layer (jmg: global or local data?)
# 35: bulk_density2 - Bulk density of soil layer (jmg: global or local data?)
# 36: bulk_density3 - Bulk density of soil layer (jmg: global or local data?)
# 37: soil_density1 - Soil particle density (jmg: global or local data?)
# 38: soil_density2 - Soil particle density (jmg: global or local data?)
# 39: soil_density3 - Soil particle density (jmg: global or local data?)
# 40: off_gmt - Time offset "off_gmt=(grid_cell_longitude*24/360)" (jmg: from our longitude)
# 41: Wcr_FRACT1 - Fractional soil moisture content at the critical point (jmg: global or local data?)
# 42: Wcr_FRACT2 - Fractional soil moisture content at the critical point (jmg: global or local data?)
# 43: Wcr_FRACT3 - Fractional soil moisture content at the critical point (jmg: global or local data?)
# 44: Wpwp_FRACT1 - Fractional soil moisture content at the wilting point (jmg: global or local data?)
# 45: Wpwp_FRACT2 - Fractional soil moisture content at the wilting point (jmg: global or local data?)
# 46: Wpwp_FRACT3 - Fractional soil moisture content at the wilting point (jmg: global or local data?)
# 47: rough - Surface roughness of bare soil (jmg: standard value)
# 48: snow_rough - Surface roughness of snowpack (jmg: standard value)
# 49: annual_prec - Average annual precipitation (jmg: from meteo data)
# 50: resid_moist1 - Soil moisture layer residual moisture (jmg: global or local data?)
# 51: resid_moist2 - Soil moisture layer residual moisture (jmg: global or local data?)
# 52: resid_moist3 - Soil moisture layer residual moisture (jmg: global or local data?)
# 53: fs_active - If set to 1, then frozen soil algorithm is activated for the grid cell (jmg: we set this to 0)


#########################################################################################################

append_soil_file = function(path_sim, soil_param, init_file) {
  
  # Filename
  
  filename = file.path(path_sim, "/params/soil_param")
  
  # CHECK THAT RESIDUAL MOISTURE AND PERMANENT WILTING POINT ARE COMPATIBLE
  
  # Wpwp_FRACT MUST be >= resid_moist / (1.0 - bulk_density/soil_density)
  
  if (soil_param$Wpwp_FRACT1 < soil_param$resid_moist1 / (1.0 - soil_param$bulk_density1/soil_param$soil_density1) ) {
    soil_param$Wpwp_FRACT1 = 1.01 * soil_param$resid_moist1 / (1.0 - soil_param$bulk_density1/soil_param$soil_density1)
  }
  
  if (soil_param$Wpwp_FRACT2 < soil_param$resid_moist2 / (1.0 - soil_param$bulk_density2/soil_param$soil_density2) ) {
    soil_param$Wpwp_FRACT2 = 1.01 * soil_param$resid_moist2 / (1.0 - soil_param$bulk_density2/soil_param$soil_density2)
  }
  
  if (soil_param$Wpwp_FRACT3 < soil_param$resid_moist3 / (1.0 - soil_param$bulk_density3/soil_param$soil_density3) ) {
    soil_param$Wpwp_FRACT3 = 1.01 * soil_param$resid_moist3 / (1.0 - soil_param$bulk_density3/soil_param$soil_density3)
  }
  
  # WRITE PARAMETERS TO A FILE
  
  fmt = paste(c("%.0f ", "%.0f ", "%.5f ", "%.5f ", rep("%.4f ", 49), "\n"), collapse = "")
  
  values_str <- sprintf(fmt,
                        soil_param$run_cell,
                        soil_param$gridcel, 
                        soil_param$lat, 
                        soil_param$lon, 
                        soil_param$infilt, 
                        soil_param$D1, 
                        soil_param$D2, 
                        soil_param$D3, 
                        soil_param$D4,
                        soil_param$expt1, 
                        soil_param$expt2, 
                        soil_param$expt3, 
                        soil_param$Ksat1, 
                        soil_param$Ksat2, 
                        soil_param$Ksat3, 
                        soil_param$phi_s1, 
                        soil_param$phi_s2,
                        soil_param$phi_s3, 
                        soil_param$init_moist1, 
                        soil_param$init_moist2, 
                        soil_param$init_moist3, 
                        soil_param$elev, 
                        soil_param$depth1, 
                        soil_param$depth2,
                        soil_param$depth3, 
                        soil_param$avg_T, 
                        soil_param$dp, 
                        soil_param$bubble1, 
                        soil_param$bubble2,
                        soil_param$bubble3, 
                        soil_param$quartz1, 
                        soil_param$quartz2, 
                        soil_param$quartz3, 
                        soil_param$bulk_density1, 
                        soil_param$bulk_density2,
                        soil_param$bulk_density3,
                        soil_param$soil_density1, 
                        soil_param$soil_density2, 
                        soil_param$soil_density3,
                        soil_param$off_gmt, 
                        soil_param$Wcr_FRACT1, 
                        soil_param$Wcr_FRACT2, 
                        soil_param$Wcr_FRACT3,
                        soil_param$Wpwp_FRACT1, 
                        soil_param$Wpwp_FRACT2, 
                        soil_param$Wpwp_FRACT3, 
                        soil_param$rough,
                        soil_param$snow_rough, 
                        soil_param$annual_prec, 
                        soil_param$resid_moist1, 
                        soil_param$resid_moist2, 
                        soil_param$resid_moist3, 
                        soil_param$fs_active)
  
  if (init_file == TRUE) {
    cat(values_str, file = filename, append = FALSE)
  } else {
    cat(values_str, file = filename, append = TRUE)
  }
  
}


#########################################################################################################

write_soil_params <- function(path_sim) {
  
  # Read global soil parameter file
  
  col_names = c("run_cell", "gridcel", "lat", "lon", "infilt", "D1", "D2", "D3", "D4",
                "expt1", "expt2", "expt3", "Ksat1", "Ksat2", "Ksat3", "phi_s1", "phi_s2",
                "phi_s3", "init_moist1", "init_moist2", "init_moist3", "elev", "depth1",
                "depth2", "depth3", "avg_T","dp", "bubble1", "bubble2", "bubble3", "quartz1",
                "quartz2", "quartz3", "bulk_density1", "bulk_density2", "bulk_density3",
                "soil_density1", "soil_density2", "soil_density3", "off_gmt", "Wcr_FRACT1",
                "Wcr_FRACT2", "Wcr_FRACT3", "Wpwp_FRACT1", "Wpwp_FRACT2", "Wpwp_FRACT3",
                "rough", "snow_rough", "annual_prec", "resid_moist1", "resid_moist2",
                "resid_moist3", "fs_active", "na")
  
  global_soil <- read.delim(file = "vic_params_global/global_soil_param_new", sep = " ", 
                            header = FALSE, strip.white = TRUE, col.names = col_names)
  
  # Read InnenforNorge
  
  col_names = c("na", "bil_id", "lon", "lat", "elev")
  
  df_norway <- read.csv("InnenforNorge_20170516.txt", header = TRUE, sep = ";", col.names = col_names)
  
  # Read file with annual average precipitation
  
  filename <- file.path(path_sim, "annual_prec.txt")
  
  df_prec <- read.csv(filename, header = TRUE, sep = ";")
  
  
  # Loop through grid cells in Norway
  
  for (inorway in 1:nrow(df_norway)) {
    
    # Find closest point in the global parameter set
    
    dist_lat <- global_soil$lat - df_norway$lat[inorway]
    dist_lon <- global_soil$lon - df_norway$lon[inorway]
    
    dist <- sqrt(dist_lat^2 + dist_lon^2)
    
    iglobal <- which(dist == min(dist))
    iglobal <- iglobal[1]
    
    # Extract row from global soil data set
    
    soil_norway <- global_soil[iglobal, ]
    
    # Replace global parameters with local if available
    
    soil_norway$gridcel     <- df_norway$bil_id[inorway]
    soil_norway$lat         <- df_norway$lat[inorway]
    soil_norway$lon         <- df_norway$lon[inorway]
    soil_norway$elev        <- df_norway$elev[inorway]
    soil_norway$off_gmt     <- df_norway$lon[inorway]*24/360
    soil_norway$annual_prec <- df_prec$annual_prec[inorway]
    
    # Append data to file
    
    if (inorway == 1) {
      append_soil_file(path_sim, soil_norway, TRUE)
    } else {
      append_soil_file(path_sim, soil_norway, FALSE)
    }
    
    # Write progress
    
    if (inorway%%1000 == 0) {
      print(paste("Wrote line ", inorway, sep = ""))
    }
    
  }
  
}


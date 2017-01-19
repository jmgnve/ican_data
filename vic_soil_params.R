

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
  
  if (init_file == TRUE) {
    cat(sprintf("%.0f ", soil_param$run_cell), file = filename, append = FALSE)
  } else {
    cat(sprintf("%.0f ", soil_param$run_cell), file = filename, append = TRUE)
  }
  
  cat(sprintf("%.0f ", soil_param$gridcel), file = filename, append = TRUE)
  cat(sprintf("%.5f ", soil_param$lat), file = filename, append = TRUE)
  cat(sprintf("%.5f ", soil_param$lon), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$infilt), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$D1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$D2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$D3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$D4), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$expt1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$expt2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$expt3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Ksat1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Ksat2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Ksat3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$phi_s1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$phi_s2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$phi_s3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$init_moist1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$init_moist2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$init_moist3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$elev), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$depth1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$depth2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$depth3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$avg_T), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$dp), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$bubble1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$bubble2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$bubble3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$quartz1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$quartz2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$quartz3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$bulk_density1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$bulk_density2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$bulk_density3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$soil_density1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$soil_density2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$soil_density3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$off_gmt), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Wcr_FRACT1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Wcr_FRACT2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Wcr_FRACT3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Wpwp_FRACT1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Wpwp_FRACT2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$Wpwp_FRACT3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$rough), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$snow_rough), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$annual_prec), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$resid_moist1), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$resid_moist2), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$resid_moist3), file = filename, append = TRUE)
  cat(sprintf("%.4f ", soil_param$fs_active), file = filename, append = TRUE)
  cat(sprintf("\n"), file = filename, append = TRUE)
  
}


#########################################################################################################

write_soil_params <- function(path_sim, annual_prec) {
  
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
  
  df_norway <- read.csv("InnenforNorge.txt", header = TRUE, sep = ";", col.names = col_names)
  
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
    soil_norway$annual_prec <- annual_prec[inorway]
    
    # Append data to file
    
    if (inorway == 1) {
      append_soil_file(path_sim, soil_norway, TRUE)
    } else {
      append_soil_file(path_sim, soil_norway, FALSE)
    }
    
    # Write progress
    
    if (inorway%%1000 == 0) {
      print(paste("Wrote line ", counter, sep = ""))
    }
    
  }
  
}


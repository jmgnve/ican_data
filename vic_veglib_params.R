#########################################################################################################

# List of vegetation library file parameters needed for vic.4.2.d
# http://vic.readthedocs.io/en/vic.4.2.d/Documentation/VegLib/

# veg_class - Vegetation class identification number (jmg: clear) 
# overstory - Flag to indicate whether or not the current vegetation type has an overstory (jmg: ?) 
# rarc - Architectural resistance of vegetation type (jmg: ?) 
# rmin - Minimum stomatal resistance of vegetation type (jmg: ?) 
# LAI (12 values) - Leaf-area index of vegetation type (jmg: ?) 
# albedo (12 values) - Shortwave albedo for vegetation type (jmg: I will check/ask if this is snow-free albedo) 
# rough (12 values) - Vegetation roughness length (jmg: ?) 
# displacement (12 values) - Vegetation displacement height (jmg: ?) 
# wind_h - Height at which wind speed is measured (jmg: 10m)
# RGL - Minimum incoming shortwave radiation at which there will be transpiration (jmg: ?) 
# rad_atten - Radiation attenuation factor (jmg: ?) 
# wind_atten - Wind speed attenuation through the overstory (jmg: ?) 
# trunk_ratio - Ratio of total tree height that is trunk (jmg: ?) 


#########################################################################################################

write_veglib_params <- function(path_sim) {
  
file_veg <- file.path(path_sim, "params/veglib_param")

cat(sprintf("#Class	OvrStry	Rarc	Rmin	JAN-LAI	FEB-LAI	MAR-LAI	APR-LAI	MAY-LAI	JUN-LAI	JUL-LAI	AUG-LAI	SEP-LAI	OCT-LAI	NOV-LAI	DEC-LAI	JAN-ALB	FEB_ALB	MAR-ALB	APR-ALB	MAY-ALB	JUN-ALB	JUL-ALB	AUG-ALB	SEP-ALB	OCT-ALB	NOV-ALB	DEC-ALB	JAN-ROU	FEB-ROU	MAR-ROU	APR-ROU	MAY-ROU	JUN-ROU	JUL-ROU	AUG-ROU	SEP-ROU	OCT-ROU	NOV-ROU	DEC-ROU	JAN-DIS	FEB-DIS	MAR-DIS	APR-DIS	MAY-DIS	JUN-DIS	JUL-DIS	AUG-DIS	SEP-DIS	OCT-DIS	NOV-DIS	DEC-DIS	WIND_H	RGL	SolAtn	WndAtn	Trunk	COMMENT\n"), file = file_veg, append = TRUE)
cat(sprintf("#This file was obtained from Keith Cherkauer on Wed Jul 21 1999.  It was originally named LDAS_veg_lib\n"), file = file_veg, append = TRUE)
cat(sprintf("1	1	60.0	250.	3.400	3.400	3.500	3.700	4.000	4.400	4.400	4.300	4.200	3.700	3.500	3.400	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	50.0	30	0.5	0.5	0.2	Evergreen Needleleaf\n"), file = file_veg, append = TRUE)
cat(sprintf("2	1	60.0	250.	3.400	3.400	3.500	3.700	4.000	4.400	4.400	4.300	4.200	3.700	3.500	3.400	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	0.12	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	1.476	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	8.04	50.0	30	0.5	0.5	0.2	Evergreen Broadleaf\n"), file = file_veg, append = TRUE)
cat(sprintf("3	1	60.0	150.	1.680	1.520	1.680	2.900	4.900	5.000	5.000	4.600	3.440	3.040	2.160	2.000	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	50.0	30	0.5	0.5	0.2	Deciduous Needleleaf\n"), file = file_veg, append = TRUE)
cat(sprintf("4	1	60.0	150.	1.680	1.520	1.680	2.900	4.900	5.000	5.000	4.600	3.440	3.040	2.160	2.000	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	50.0	30	0.5	0.5	0.2	Deciduous Broadleaf\n"), file = file_veg, append = TRUE)
cat(sprintf("5	1	60.0	200.	1.680	1.520	1.680	2.900	4.900	5.000	5.000	4.600	3.440	3.040	2.160	2.000	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	50.0	50	0.5	0.5	0.2	Mixed Cover\n"), file = file_veg, append = TRUE)
cat(sprintf("6	1	60.0	200.	1.680	1.520	1.680	2.900	4.900	5.000	5.000	4.600	3.440	3.040	2.160	2.000	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	0.18	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	1.230	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	6.70	50.0	50	0.5	0.5	0.2	Woodland\n"), file = file_veg, append = TRUE)
cat(sprintf("7	0	40.0	125.	2.000	2.250	2.950	3.850	3.750	3.500	3.550	3.200	3.300	2.850	2.600	2.200	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	5	75.	0.5	0.5	0.2	Wooded Grasslands\n"), file = file_veg, append = TRUE)
cat(sprintf("8	0	50.0	135.	2.000	2.250	2.950	3.850	3.750	3.500	3.550	3.200	3.300	2.850	2.600	2.200	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	5	75.	0.5	0.5	0.2	Closed Shrublands\n"), file = file_veg, append = TRUE)
cat(sprintf("9	0	50.0	135.	2.000	2.250	2.950	3.850	3.750	3.500	3.550	3.200	3.300	2.850	2.600	2.200	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.19	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	0.495	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	1.00	5	75.	0.5	0.5	0.2	Open Shrublands\n"), file = file_veg, append = TRUE)
cat(sprintf("10	0	25.0	120.	2.000	2.250	2.950	3.850	3.750	3.500	3.550	3.200	3.300	2.850	2.600	2.200	0.20	0.20	0.20	0.20	0.20	0.20	0.20	0.20	0.20	0.20	0.20	0.20	0.0738	0.0738	0.0738	0.0738	0.0738	0.0738	0.0738	0.0738	0.0738	0.0738	0.0738	0.0738	0.402	0.402	0.402	0.402	0.402	0.402	0.402	0.402	0.402	0.402	0.402	0.402	3	100	0.5	0.5	0.2	Grasslands\n"), file = file_veg, append = TRUE)
cat(sprintf("11	0	25.0	120.	0.050	0.020	0.050	0.250	1.500	3.0000	4.500	5.0000	2.5000	0.500	0.050	0.020	0.10	0.10	0.10	0.10	0.20	0.20	0.20	0.20	0.20	0.10	0.10	0.10	0.006	0.006	0.006	0.006	0.012	0.062	0.123	0.185	0.215	0.215	0.006	0.006	0.034	0.034	0.034	0.034	0.067	0.335	0.670	1.005	1.173	1.173	0.034	0.034	2	100	0.5	0.5	0.2	Crop land (corn)\n"), file = file_veg, append = TRUE)

}
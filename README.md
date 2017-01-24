# ICAN DATA HANDLING

## Ingjerds files

Files from Ingjerd are found in these folders:

`/hdata/watch/iha/hfou_klima/`

`/local/hm/iha/hfou-klima/`

## Simulation results by vic

The vic simulations are stored on l-klima in this folder:

`/data02/Ican/vic_sim/past_1km/`

## Notes about script related to the vic model

We are using VIC.4.2.d., which is documented [here](http://vic.readthedocs.io/en/vic.4.2.d/).

- *vic_script.R*: start script for preparing vic input files.
- *vic_meteo_input.R*: code for generating [meteorological forcings](http://vic.readthedocs.io/en/vic.4.2.d/Documentation/ForcingData/) to vic.
- *vic_soil_params.R*: code for generating the [soil parameter file](http://vic.readthedocs.io/en/vic.4.2.d/Documentation/SoilParam/) for vic.
- *vic_veg_params.R*: code for generating the [vegetation parameter file](http://vic.readthedocs.io/en/vic.4.2.d/Documentation/VegParam/) for vic.
- *vic_veglib_params.R*: code for generating the [vegetation library file](http://vic.readthedocs.io/en/vic.4.2.d/Documentation/VegLib/) for vic.
- *vic_global_params.R*: code for generating the [global parameter file](http://vic.readthedocs.io/en/vic.4.2.d/Documentation/GlobalParam/) for vic.
- *test_iha_results.R* and *test_real_results.R*: files for testing the outputs of vic-mtclim
- *vic_reading_files.R*: code for reading the vic output files.

## Metadata

- List with gridcells in Trøndelag

## Todos

- From time series files to grids
- When reading from time series to grids, check plausibility of the results (are the meteo forecings within reasonable limits?)
- Aggregate to larger grid resolutions
- Check all VIC parameters
- Combine with HBV preparation?
- Select grid cells in polygons


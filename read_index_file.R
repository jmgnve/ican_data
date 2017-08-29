read_index_file <- function(filename) {
  
  fid <- file(filename)
  
  data <- readLines(fid)
  
  close(fid)
  
  data <- strsplit(data, split = " ")
  
  wsh_index <- vector("list", length(data))
  drainage_basin_key <- vector("integer", length(data))
  
  for (iwsh in 1:length(data)) {
    
    wsh_index[[iwsh]] <- as.integer(data[[iwsh]][5:length(data[[iwsh]])]) + 1 # Index starts at zero
    
    drainage_basin_key[iwsh] <- data[[iwsh]][4]
    
  }
  
  names(wsh_index) <- drainage_basin_key
  
  return(wsh_index)
  
}

rm(list = ls())
library(here())
library(httr)
options(stringsAsFactors = FALSE)

matrices <- list.files('../phylodom/data/')
dom.metadata <- read.csv('../phylodom/metadata/metadata.csv')

## Change filenames to remove .csv, hyphen to underscore ##
dom.metadata$fileid <- gsub(x = gsub(x = dom.metadata$fileid, '.csv', ''), '-', '_')


dom.data <- list()
for(mat in matrices){
  ### Read in matrix, add dimnames, remove diagonals, convert to numeric ###
  working.mat <- as.matrix(read.table(paste0('../phylodom/data/',mat), 
                                      sep = ',', header = TRUE, row.names = 1))
  diag(working.mat) <- NA
  class(working.mat) <- 'numeric' 
  #########################################################################
  
  ### Change working name ###
  mat <- gsub(x = gsub(x = mat, '.csv', ''), '-', '_')
  
  ### structure = dom.data$matrix[[45]]
  dom.data$matrix[length(dom.data$matrix)+1][[1]] <- working.mat
  dom.data$fileid[length(dom.data$fileid)+1][[1]] <- mat

  ### Add other columns from metadata
  for(col in names(dom.metadata)){
    if(col == 'fileid')
      next
    dom.data[[col]][length(dom.data[[col]])+1][[1]] <- dom.metadata[dom.metadata$fileid == mat,col]
  }

  # ### structure = dom.data$fileid$matrix
  # ##### Combine matrix and metadata #####
  # mat.data <- as.list(metadata[metadata$fileid == mat,])
  # mat.data$matrix <- working.mat
  # 
  # ## reorder so that matrix is first
  # mat.data <- mat.data[c('matrix', names(metadata))]
  # 
  # ### Save matrix in master list
  # dom.data[[mat]] <- mat.data
}



### make sure that metadata is in the same order as the matrices in dom.data
dom.metadata <- dplyr::left_join(data.frame(fileid = unlist(dom.data$fileid)),
                      dom.metadata, by = 'fileid')

### Save metadata and dom.data
save(dom.metadata, file = 'data/dom.metadata.RData')
save(dom.data, file = 'data/dom.data.RData')

devtools::document()

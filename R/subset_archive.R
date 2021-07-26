#' Subset DomArchive data
#' 
#' Select certain data or data + metadata from `dom.data` by filtering by columns
#' in the metadata or by supplying a list of fileids. 
#' 
#' @param dataset The dataset to be subsetted. Defaults to dom.data, the data 
#' object supplied with the package. Only objects with the same structure as dom.data
#' will work. 
#' @param fileids Optional set of unique identifiers to be used to subset `dataset`. These must 
#' be in names(dataset). If no fileids supplied, filtering will be done using `columns` and `values`. 
#' @param columns Only used if fileids is NULL. A list of column names (must be in `names(dom.metadata)`)
#' to filter data by. 
#' @param values Only used if fileids is NULL. A list of values corresponding to
#' the columns supplied in `columns`. Only rows with `values` at `columns` will
#' be retained. Must be supplied with `columns` and must be the same length as `columns`. 
#' @param return.intxdata.only Should only matrices be returned (TRUE), or should both
#' matrix and metadata be returned (FALSE). 
#' 
#' @examples
#' 
#' ## Data from SchjelderupEbbe's 1922 paper on pecking order of domestic hens
#' subset_archive(fileids = c('SchjelderupEbbe_1922a', 'SchjelderupEbbe_1922b'))
#' 
#' ## All data from captive primates
#' subset_archive(columns = list('order', 'captivity'), values = list('Primates', 'Captive'))
#' 
#' #' ## All data from captive primates - subset using dom.metadata
#' subset_archive(fileids = dom.metadata[dom.metadata$order == 'Primates' & dom.metadata$captivity == 'Captive',]$fileid)
#' 
#' @export


subset_archive <- function(dataset = dom.data, fileids = NULL, columns = NULL, values = NULL, return.intxdata.only = FALSE){
  
  #-------ERROR CHECKING------#
  
  if(!is.null(fileids) & (!is.null(columns) | !is.null(values))){
    warning("'fileids' provided. Ignoring 'columns' and 'values' arguments")
  }
  
  if(is.null(fileids) & ((is.null(columns) | is.null(values)))){
    stop("Must provide either 'fileids' or both 'columns' and 'values' for data subsetting")
  }
  
  
  if(is.null(fileids)){
    
    if(!all(columns %in% names(dataset[[1]]$metadata))){
      stop(columns[which(!columns %in% names(dataset[[1]]$metadata))], ' not a column in metadata')
    }
    
    if(length(columns) != length(values)){
      stop("length of 'columns' must equal length of 'values'")
    }
    
    # 
    if(length(columns) == 1 & !'list' %in% class(columns))
      columns <- list(columns)
    
    if(length(values) == 1 & !'list' %in% class(values))
      values <- list(values)
    
    indices <- TRUE
    for(i in 1:length(columns)){
      indices <- indices & purrr::map_df(dataset, "metadata")[[columns[[i]]]] %in% values[[i]]
    }
    if(return.intxdata.only){
      return(purrr::map(dataset, 'matrix')[indices])
    }else{
      return(dataset[indices])
    }
    
  }else{
    
    if(!all(fileids %in% names(dataset))){
      stop("some fileids not in names(dataset). Mismatches: ", paste(fileids[which(!fileids %in% names(dataset))], collapse = ', '))
    }
    
    if(return.intxdata.only){
      return(purrr::map(dataset, 'matrix')[fileids])
    }else{
      return(dataset[fileids])
    }
  }
}
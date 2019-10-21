#' dom.data
#' 
#' List of dominance matrices and associated metadata. List is organized such that
#' the 1st dominance matrix corresponds to the 1st entry in the other elements of the list,
#' and so on. 
#' 
#' @format List of 16 elements
#'   \describe{
#'     \item{matrix}{List of matrices of dominance interactions}
#'     \item{fileid}{File identifier associated with each matrix. Format is Author_Year}
#'     \item{taxon}{Broad taxonomic category for species}
#'     \item{and so on}{...}
#'   }
"dom.data"
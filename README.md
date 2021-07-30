# DomArchive: a century of a published dominance data


`DomArchive` is a data package compiling dominance interaction data published
over a century of research. The goal of the package is to facilitate comparative
research on the structure and function of dominance hierarchies. The archive 
contains 434 agonistic interaction datasets, totaling over 241,000 interactions.

### Installing the package

To install the package with the vignette, run (requires `devtools` package):  

`devtools::install_github(‘DomArchive/DomArchive', build_vignettes = TRUE)`    

To view an introductory vignette about how to use the package, run:  

`vignette('introduction', package = "DomArchive")`  

### What's in the package? 

The package contains three primary elements:     

1. `dom.data` - a list containing both data and metadata. Each element of the list
is a unique data entry, named after the first author and year of publication.
Each element of the list contains two named elements -- `matrix` containing the 
interaction sociomatrix and `metadata` containing the metadata associated with the 
data. In cases where data are in an edgelist rather than a matrix, the first named
element is `edgelist` instead of `matrix`.   

2. `dom.metadata` - a dataframe containing the metadata for the complete dataset. 
The information in the `dom.metadata` dataframe is exactly identical to what you would get if you
extracted and combined every `metadata` element in `dom.data`.  

3. `subset_archive()` - a function for selecting subsets of the data based upon the 
metadata. Users can either provide a vector of `fileids` specifying the datasets to return,
or the users can provide paired `columns` and `values` lists specifying metadata columns
and the associated values to retain for each column.  


## Metadata

Here is a summary of the metadata associated with each datafile:  

|Metadata Column| Meaning                           | Potential values
|---------------|-----------------------------------|-----------------
|fileid         | Unique identifier for data        |
|order          | Order (taxonomic rank)            |
|species        | Species name                      |
|common_name    | Common name                       |
|study_site     | Nation where study was conducted  |
|captivity      | Captive or free-ranging animals?  | "Captive", "Natural"
|sex            | Males, females, or both?          | "M", "F", "MF"
|age            | What age classes?                  | "Adult", "Non-Adult", "Mixed"
|measure        | What behavior was measured?       |
|data_location  | Where is data in reference (e.g., Tb1)?          |
|countbinary    | Are data raw counts or binary? (edgelists are counts) | "Count", "Binary"
|repeat_group   | Are there multiple datasets for this group? | "Yes", "No"
|groupid        | Unique identifier for social group|
|matrix_edgelist| Are data in matrix or edgelist format?    | "Matrix", "Edgelist"
|edgelist_time_meaning | For edgelist data, what is the meaning (units) of the "time" column |
|note           | Miscellaneous notes               |
|full_citation  | Source for the data               |

Additionally, metadata includes some quantities calculated from the interaction data. 
Calculations were made using functions in the `compete` package (https://github.com/jalapic/compete).  

|Quantity                    | Details                           
|----------------------------|------------------------------------
|number_individuals          | Number of individuals in the dataset
|number_interactions         | Number of interactions in the dataset
|interactions_per_individual | Number of interactions per individual
|proportion_unknown          | Proportion of relationships for which there are no observations (matrix data only)
|dci                         | Directional consistency index (Van Hooff & Wensing 1987) (count matrix data only)
|ttri                        | Triangle transitivity index (Shizuka & McDonald 2012) (matrix data only)
|ds_steepness                | Hierarchy steepness calculated from David's Scores (de Vries et al 2006) (count matrix data only)
|modified_landaus_h          | Modified Landau's h` measure of linearity (de Vries 1995) (matrix data only)


## Get involved

If you would like to contribute data to the package, or if you find issues that would like to see addressed, please [create an Issue](https://github.com/DomArchive/DomArchive/issues). We appreciate your input!  
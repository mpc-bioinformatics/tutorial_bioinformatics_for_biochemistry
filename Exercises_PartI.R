### Installation of packages

install.packages("devtools")
install.packages("remotes")
pak::pak("mpc-bioinformatics/ProtStatsWF@introduce_SE")
install.packages("ggVennDiagram")


################################################################################
### Loading the package
library(ProtStatsWF)


### Exercise 1


### A) Import and prepare the quantitative proteomics data "Data/proteins_HCC.csv"
### together with the table "Data/clinical_data.csv" as a sample info table
### using the function prepareDataSE.
### Have a look at the help page with "?prepareDataSE" and set the settings so
### that the data is log-transformed, Zeros are transformed into missing values
### and the data is not further normalized.

D_nonorm <- prepareDataSE(dataPath = "Data/proteins_HCC.csv", # you may need to change the path here
                          intensityColumns = 6:43,
                          sampleInfoPath = "Data/clinical_data.csv", # you may need to change the path here
                          sampleNameColumn = "Sample",
                          fileType = "csv",

                            ## add further arguments here for log-transformation etc
                              )


### B) Apply the function workflow_QC on the resulting object. Look at the
### generated plots. Do you think a normalization is necessary?

workflow_QC(D = D_nonorm,
            groupColumn = ,  # set column with group information here
            outPath = , # select a folder here, where the results are saves (must exist!)
            suffix = "_nonorm")


### C) Import and prepare the data 3 further times, choosing median, quantile
### and loess as normalization methods.
### Again, apply the workflow_QC.
### Important: make sure that you set different suffixes using the "suffix"
### setting or safe the results in different folders to avoid your previous results
### from being overwritten!
### Compare the plots between the different normalization methods.
### Which normalization would you choose?



### D) (optional) For your normalization of choice: make a PCA separately and
### try out different versions by setting colour and shape to different columns
### of the clinical data. Have a look at the help page of the PCA_Plot() function
### to see which settings you can use.



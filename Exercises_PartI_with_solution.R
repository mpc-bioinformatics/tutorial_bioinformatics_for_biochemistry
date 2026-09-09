### Installation of packages

install.packages("pak")
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

D_nonorm <- prepareDataSE(dataPath = "Data/proteins_HCC.csv",
                          intensityColumns = 6:43,
                          sampleInfoPath = "Data/clinical_data.csv",
                          sampleNameColumn = "Sample",
                          fileType = "csv",
                          doLogTrans = TRUE,
                          normMethod = "nonorm",
                          zeroToNA = TRUE
)


### B) Apply the function workflow_QC on the resulting object. Look at the
### generated plots. Do you think a normalization is necessary?

workflow_QC(D = D_nonorm,
            groupColumn = ,  # set column with group information here
            outPath = , # select a folder here, where the results are saves (must exist!)
            suffix = "_nonorm")

workflow_QC(D = D_nonorm,
            groupColumn = "Group",  # set column with group information here
            outPath = "results", # select a folder here, where the results are saves (must exist!)
            suffix = "_nonorm")

### C) Import and prepare the data 3 further times, choosing median, quantile
### and loess as normalization methods.
### Again, apply the workflow_QC.
### Important: make sure that you set different suffixes using the "suffix"
### setting or safe the results in different folders to avoid your previous results
### from being overwritten!
### Compare the plots between the different normalization methods.
### Which normalization would you choose?

D_median <- prepareDataSE(dataPath = "Data/proteins_HCC.csv",
                          intensityColumns = 6:43,
                          sampleInfoPath = "Data/clinical_data.csv",
                          sampleNameColumn = "Sample",
                          fileType = "csv",
                          doLogTrans = TRUE,
                          normMethod = "median",
                          zeroToNA = TRUE
)

D_quantile <- prepareDataSE(dataPath = "Data/proteins_HCC.csv",
                          intensityColumns = 6:43,
                          sampleInfoPath = "Data/clinical_data.csv",
                          sampleNameColumn = "Sample",
                          fileType = "csv",
                          doLogTrans = TRUE,
                          normMethod = "quantile",
                          zeroToNA = TRUE
)

D_loess <- prepareDataSE(dataPath = "Data/proteins_HCC.csv",
                          intensityColumns = 6:43,
                          sampleInfoPath = "Data/clinical_data.csv",
                          sampleNameColumn = "Sample",
                          fileType = "csv",
                          doLogTrans = TRUE,
                          normMethod = "loess",
                          zeroToNA = TRUE
)


workflow_QC(D = D_median,
            groupColumn = "Group",
            outPath = "results",
            suffix = "_median")

workflow_QC(D = D_quantile,
            groupColumn = "Group",
            outPath = "results",
            suffix = "_quantile")

workflow_QC(D = D_loess,
            groupColumn = "Group",
            outPath = "results",
            suffix = "_loess")


### D) (optional) For your normalization of choice: make a PCA separately and
### try out different versions by setting colour and shape to different columns
### of the clinical data. Have a look at the help page of the PCA_Plot() function
### to see which settings you can use.


PCA_Plot(SE = D_loess$SE,
         groupForColour = "Age",
         colourType = "continuous",
         groupForShape = "Gender")

PCA_Plot(SE = D_loess$SE,
         groupForColour = "Tumor_Staging",
         groupForShape = "Grading")

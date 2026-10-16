### Installation of packages

install.packages("pak")
pak::pak("mpc-bioinformatics/ProtStatsWF@introduce_SE")

setwd("tutorial_bioinformatics_for_biochemistry")


################################################################################
### Loading the necessary packages
library(ProtStatsWF)
library(SummarizedExperiment)



################################################################################

### Exercise 1

### A) Import and prepare the quantitative proteomics data "Data/proteins_HCC.csv"
### together with the table "Data/clinical_data.csv" as a sample info table
### using the function prepareData.
### Have a look at the help page with "?prepareData" and set the settings so
### that the data is log-transformed, Zeros are transformed into missing values
### and the data is not further normalized.

# D_nonorm <- prepareData(dataPath = "Data/proteins_HCC.csv", # you may need to change the path here
#                         intensityColumns = 6:43,
#                         sampleInfoPath = "Data/clinical_data.csv", # you may need to change the path here
#                         sampleNameColumn = "Sample",
#                         # add further arguments here for log-transformation etc
#                         )

D_nonorm <- prepareData(dataPath = "Data/proteins_HCC.csv",
                          intensityColumns = 6:43,
                          sampleInfoPath = "Data/clinical_data.csv",
                          sampleNameColumn = "Sample",
                          doLogTrans = TRUE,
                          normMethod = "nonorm",
                          zeroToNA = TRUE
)


### B) Apply the function workflow_QC on the resulting object. Look at the
### generated plots. Do you think a normalization is necessary?

# workflow_QC(D = D_nonorm,
#             groupColumn = ,  # set column with group information here
#             outputPath = , # select a folder here, where the results are saves (must exist!)
#             suffix = "_nonorm")

workflow_QC(D = D_nonorm,
            groupColumn = "Group",  # set column with group information here
            outputPath = "results", # select a folder here, where the results are saves (must exist!)
            suffix = "_nonorm")

### C) Import and prepare the data 3 further times, choosing median, quantile
### and loess as normalization methods.
### Again, apply the workflow_QC.
### Important: make sure that you set different suffixes using the "suffix"
### setting or safe the results in different folders to avoid your previous results
### from being overwritten!
### Compare the plots between the different normalization methods.
### Which normalization would you choose?

D_median <- prepareData(dataPath = "Data/proteins_HCC.csv",
                        intensityColumns = 6:43,
                        sampleInfoPath = "Data/clinical_data.csv",
                        sampleNameColumn = "Sample",
                        doLogTrans = TRUE,
                        normMethod = "median",
                        zeroToNA = TRUE
)

D_quantile <- prepareData(dataPath = "Data/proteins_HCC.csv",
                          intensityColumns = 6:43,
                          sampleInfoPath = "Data/clinical_data.csv",
                          sampleNameColumn = "Sample",
                          doLogTrans = TRUE,
                          normMethod = "quantile",
                          zeroToNA = TRUE
)

D_loess <- prepareData(dataPath = "Data/proteins_HCC.csv",
                        intensityColumns = 6:43,
                        sampleInfoPath = "Data/clinical_data.csv",
                        sampleNameColumn = "Sample",
                        doLogTrans = TRUE,
                        normMethod = "loess",
                        zeroToNA = TRUE
)


workflow_QC(D = D_median,
            groupColumn = "Group",
            outputPath = "results",
            suffix = "_median")

workflow_QC(D = D_quantile,
            groupColumn = "Group",
            outputPath = "results",
            suffix = "_quantile")

workflow_QC(D = D_loess,
            groupColumn = "Group",
            outputPath = "results",
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





#### Exercise 2

### A) Apply a paired (!) t-test to compare HCC versus Control group.
### Here we extract the data and variables we need to perform the t-test from
### the SummarizedExperiment object that prepareDataSE() function generates.
### In this example here, the loess-normalized data is used but you can use
### another one if you like!

### Have a look at the help page of the ttest() function and
### apply the t-test to the data. Make sure to set the settings for a paired
### t-test and to only test proteins with at least 5 valid pairs of observations.
### Also, make sure that the intensities are not log-transformed before the test,
### as the data was already log-transformed before normalization. However, the
### fold changes should be calculated on the back-transformed data (original data
### scale). So set the settings for logBeforeTest and delogForFC accordingly.

ttest_result <- ttest(SE = D_loess$SE, assay = "intensity_norm",
                      groupColumn = "Group",
                      sampleColumn = "PatientID",
                      paired = TRUE, varEqual = FALSE,
                      logBeforeTest = FALSE, delogForFC = TRUE, logBase = 2,
                      minObs = 5)


### B) Draw a Volcano plot and mark the proteins with a significant p-value after
### FDR-correction in a different colour. For this, use the VolcanoPlot_ttest()
### function from the ProtStatsWF package. A look at the help page of this function
### will be helpful.

VolcanoPlot_ttest(RES = ttest_result,
                  columnNameP = "p",
                  columnNamePadj = "p.fdr",
                  columnNameFC = "FC_HCC_divided_by_C")

#### TODO: hier erstmal adjustierte p-Werte nicht einfärben

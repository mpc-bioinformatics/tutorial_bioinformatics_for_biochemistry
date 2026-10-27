### Installation of packages

install.packages("pak")
pak::pak("mpc-bioinformatics/ProtStatsWF@0.3.1")
pak::pak("affy")

setwd("partII")


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
### The saveRDS function then saves the normalized data as ad rds object
### which can be loaded later.

D_nonorm <- prepareData(dataPath = "Data/proteins_HCC.csv", # you may need to change the path here
                        intensityColumns = 6:43,
                        sampleInfoPath = "Data/clinical_data.csv", # you may need to change the path here
                        sampleNameColumn = "Sample",
                        # add further arguments here for log-transformation etc
                        )
saveRDS(D_nonorm, file = "") ## set filepath and name to save the data



### B) Apply the function workflow_QC on the resulting object. Look at the
### generated plots. Do you think a normalization is necessary?

workflow_QC(D = D_nonorm,
            groupColumn = ,  # set column with group information here
            outputPath = , # select a folder here, where the results are saves (must exist!)
            suffix = "_nonorm")


### C) Import and prepare the data 3 further times, choosing median, quantile
### and loess as normalization methods. Do not forget to save the data as rds files.
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
### Hint: you can extract the SE object (SummarizedExperiment) via D_loess$SE.






#### Exercise 2

### A) Apply a paired (!) t-test to compare HCC versus Control group.
### Here we extract the data and variables we need to perform the t-test from
### the SummarizedExperiment object that prepareData() function generates.
### In this example here, the loess-normalized data is used but you can use
### another one if you like!
### Hint: you can extract the SE object (SummarizedExperiment) via D_loess$SE.

### Have a look at the help page of the ttest() function and
### apply the t-test to the data. Make sure to set the settings for a paired
### t-test and to only test proteins with at least 5 valid pairs of observations.
### Also, make sure that the intensities are not log-transformed before the test,
### as the data was already log-transformed before normalization. However, the
### fold changes should be calculated on the back-transformed data (original data
### scale). So set the settings for logBeforeTest and delogForFC accordingly.
### Save the t-test results in an rds file so we can re-use it next time!

ttest_result <- ttest(SE = D_loess$SE, assay = "intensity_norm",
                     ### add further arguments here
                     )


### B) Draw a Volcano plot and mark the proteins with a significant p-value after
### FDR-correction in a different colour. For this, use the VolcanoPlot_ttest()
### function from the ProtStatsWF package. A look at the help page of this function
### will be helpful.
### Choose "p.fdr" as columnNamePadj. We will learn next time what it means.


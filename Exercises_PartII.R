### Loading the package
library(ProtStatsWF)
library(SummarizedExperiment)

#### Exercise 2

### A) Apply a paired (!) t-test to compare HCC versus Control group.
### Here we extract the data and variables we need to perform the t-test from
### the SummarizedExperiment object that prepareDataSE() function generates.
### In this example here, the loess-normalized data is used but you can use
### another one if you like!
D <- as.data.frame(assay(D_loess$SE))
id <- as.data.frame(rowData(D_loess$SE))
group <- as.factor(colData(D_loess$SE)$Group)
sample <- as.factor(colData(D_loess$SE)$PatientID)

### Have a look at the help page of the ttest() function and
### apply the t-test to the data. Make sure to set the settings for a paired
### t-test and to only test proteins with at least 5 valid pairs of observations.
### Also, make sure that the intensities are not log-transformed before the test,
### as the data was already log-transformed before normalization. However, the
### fold changes should be calculated on the back-transformed data (original data
### scale). So set the settings for log_before_test and delog_for_FC accordingly.

ttest_result <- ttest(...)

### B) Have a closer look at the t-test results and answer the following questions:
### How many proteins are significant (p <= 0.05)?


### How many proteins are significant after FDR-correction (column p.fdr)?


### How many proteins are significant after FDR-correction and have a
### fold change > 2 or < 1/2?



### C) Draw a Volcano plot and mark the proteins with a significant p-value after
### FDR-correction in a different colour. For this, use the VolcanoPlot_ttest()
### function from the ProtStatsWF package. A look at the help page of this function
### will be helpful.




### D) As an alternative, we can calculate the limma test now. To be comparable
### with the t-test results, we only want to calculate it for proteins with
### a valid p-value for the t-test:
D_limma <- D[!is.na(ttest_result$p), ]


### load the limma package and perform the limma test.
library(limma)

### Apply the limma test. To mimick the paired t-test, add the sample variable
## as a blocking factor in the design matrix (~ group + sample).




### E) Create a Volcano Plot using the limma results. Be careful, as the
### limma result has different column names and the fold change columns is
### already log-transformed! Use the VolcanoPlot_ttest() function again and
### set the settings accordingly.




### F) Compare the results (Volcano plot, number of significant proteins, histogram
### of p-values).




### G) (optional) Use the ggVennDiagram package to visualize the overlap of
### significant proteins between the t-test and limma results.
### Have alook at this website for further information and example code
### for the ggVennDiagram package: https://gaospecial.github.io/ggVennDiagram/
## and the help page of the ggVennDiagram() function.

library(ggVennDiagram)
library(ggplot2)




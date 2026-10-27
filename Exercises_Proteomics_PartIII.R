
#install.packages("pak")
#pak::pak("mpc-bioinformatics/ProtStatsWF@0.3.1")
pak::pak("ggVennDiagram")

### Loading the package
library(ProtStatsWF)
library(SummarizedExperiment)
library(ggVennDiagram)
library(ggplot2)
library(ComplexHeatmap)
library(limma)

setwd("partIII")

################################################################################
## load data from last time

D_loess <- readRDS("intermediate_results/D_loess.rds")

ttest_result <- readRDS("intermediate_results/ttest_result.rds")


################################################################################

#### Exercise 3

## A) Have a look at the t-test results from the last session.

### Answer the following questions:
### How many proteins are significant (p <= 0.05)?


### How many proteins are significant after FDR-correction (column p.fdr)?


### How many proteins are significant after FDR-correction and have a
### fold change > 2 or < 1/2?




### B) As an alternative, we can calculate the limma test now. To be directly
### comparable with the t-test results, we only want to calculate it for
### proteins with a valid p-value for the t-test.
### Additionally we extract group and patient information from the SE object.
D <- assay(D_loess$SE, "intensity_norm")
D_limma <- D[!is.na(ttest_result$p), ]
patient <- colData(D_loess$SE)$PatientID
group <- colData(D_loess$SE)$Group


### Apply the limma test. To mimic the paired t-test, add the patient variable
## as a blocking factor in the design matrix (~ group + patient).



### C) Create a Volcano Plot using the limma results. Be careful, as the
### limma result has different column names and the fold change columns is
### already log-transformed! Use the VolcanoPlot_ttest() function again and
### set the settings accordingly.




### D) Compare the results (Volcano plot, number of significant proteins, histogram
### of p-values).



### E) (optional) Use the ggVennDiagram package to visualize the overlap of
### significant proteins between the t-test and limma results.
### Have alook at this website for further information and example code
### for the ggVennDiagram package: https://gaospecial.github.io/ggVennDiagram/
## and the help page of the ggVennDiagram() function.






#### Exercise 2


### A) Prepare the data for clustering and the Heatmap. First, filter the data so
### that it only contains the proteins
### that are significant after p-value correction and have a fold change
### >2 or < 1/2 for the limma results (be careful, in limma the fold changes are
### already log-transformed!).



### B) Generate a basic heatmap by using the function Heatmap() from the ComplexHeatmap package.



### C) You will see, that you cannot see differences between the samples in the heatmap well,
### but differences between high and low-abundant proteins are very dominant.
### This is because the data is not scaled.
### Apply a Z-scoring on the data by applying the scale()-function. Be careful,
### as the scale-function works on columns, but we want to Z-score the data by row.
### Therefore, we need to transpose the data before and after applying the scale function.
### For this, you can use the function t().
### Then, generate the heatmap again using the scaled protein intensities.



### D) By default, the row and column clustering is done using the euclidean distance.
### Have a look at the help page of the Heatmap() function and choose a distance
### that is more appropriate for proteomics data.



### E) The ComplexHeatmap R package allows heatmap annotations.
### We want to annotate the age and gender of the patients as column annotations.
### For that we want to use the top_annotation argument that expects a HeatmapAnnotation object.
### To create a HeatmapAnnotation object, we need to provide the annotation data as a data frame.
### The columns of the data frame will be the annotation variables and the rows will be the samples.
### In our case, we want to annotate the age and gender of the patients.
### We can extract this information from the colData of our SummarizedExperiment object D_loess.
age <- colData(D_loess$SE)$Age
gender <- colData(D_loess$SE)$Gender

### Now we create a small data.frame of these columns and use the HeatmapAnnotation() function to create the annotation object.

annotation_df <- data.frame(age = age, gender = gender)

### Create the Heatmap again, using the HeatmapAnnotation object as top annotation.



### Is there a pattern in the heatmap that is related to the age or gender of the patients?


### F) (optional) Add the information about the Tumor staging and Grading form the colData
### of the SummarizedExperiment object D_loess as row annotations to the heatmap.
### For that, you can use the row_annotation argument of the Heatmap() function.
### Again, you need to create a HeatmapAnnotation object for the row annotation.
### If you like, find out how to set colours for the different annotation variables
### to make the heatmap more visually appealing (by default, random colours are used).
### For this, you can have a look at the ComplexHeatmap documentation at
### https://jokergoo.github.io/ComplexHeatmap-reference/book.


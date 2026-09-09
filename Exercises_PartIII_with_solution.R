#### Exercise 2


### A) Prepare the data for clustering and the Heatmap. First, filter the data so
### that it only contains the proteins
### that are significant after p-value correction and have a fold change
### >2 or < 1/2 for the limma results (be careful, in limma the fold changes are
### already log-transformed!).


ind_limma <- which(limma_result$adj.P.Val <= 0.05 & (limma_result$logFC >= 1 | limma_result$logFC  <= -1))
D_HM <- D_limma[ind_limma, ]


### B) Generate a basic heatmap by using the function Heatmap() from the ComplexHeatmap package.

library(ComplexHeatmap)
Heatmap(D_HM)

### C) You will see, that you cannot see differences between the samples in the heatmap well,
### but differences between high and low-abundant proteins are very dominant.
### This is because the data is not scaled.
### Apply a Z-scoring on the data by applying the scale()-function. Be careful,
### as the scale-function works on columns, but we want to Z-score the data by row.
### Therefore, we need to transpose the data before and after applying the scale function.
### For this, you can use the function t().
### Then, generate the heatmap again using the scaled protein intensities.

D_HM_scaled <- t(scale(t(D_HM)))

Heatmap(D_HM_scaled)


### D) By default, the row and column clustering is done using the euclidean distance.
### Have a look at the help page of the Heatmap() function and choose a distance
### that is more appropriate for proteomics data.

Heatmap(D_HM_scaled,
        clustering_distance_rows = "pearson",
        clustering_distance_columns = "pearson")

Heatmap(D_HM,
        clustering_distance_rows = "pearson",
        clustering_distance_columns = "pearson")


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

Heatmap(D_HM_scaled,
        clustering_distance_rows = "pearson",
        clustering_distance_columns = "pearson",
        top_annotation = HeatmapAnnotation(df = annotation_df))


### Is there a pattern in the heatmap that is related to the age or gender of the patients?


### F) (optional) Add the information about the Tumor staging and Grading form the colData
### of the SummarizedExperiment object D_loess as row annotations to the heatmap.
### For that, you can use the row_annotation argument of the Heatmap() function.
### Again, you need to create a HeatmapAnnotation object for the row annotation.
### If you like, find out how to set colours for the different annotation variables
### to make the heatmap more visually appealing (by default, random colours are used).
### For this, you can have a look at the ComplexHeatmap documentation at
### https://jokergoo.github.io/ComplexHeatmap-reference/book.
age <- colData(D_loess$SE)$Age
gender <- colData(D_loess$SE)$Gender
tumor_staging <- colData(D_loess$SE)$Tumor_Staging
tumor_grading <- colData(D_loess$SE)$Grading

annotation_df2 <- data.frame(age = age, gender = gender, staging = tumor_staging, grading = tumor_grading)

Heatmap(D_HM_scaled,
        clustering_distance_rows = "pearson",
        clustering_distance_columns = "pearson",
        top_annotation = HeatmapAnnotation(df = annotation_df2))

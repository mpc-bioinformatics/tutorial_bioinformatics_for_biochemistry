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

ttest_result <- ttest(D = D, id = id, group = group, sample = sample,
                      paired = TRUE, var.equal = FALSE,
                      log_before_test = FALSE, delog_for_FC = TRUE, log_base = 2,
                      min_obs_per_group = 5)

### B) Have a closer look at the t-test results and answer the following questions:
### How many proteins are significant (p <= 0.05)?
sum(ttest_result$p <= 0.05, na.rm = TRUE)
# [1] 1153

### How many proteins are significant after FDR-correction (column p.fdr)?
sum(ttest_result$p.fdr <= 0.05, na.rm = TRUE)
# [1] 954

### How many proteins are significant after FDR-correction and have a
### fold change > 2 or < 1/2?
sum(ttest_result$p.fdr <= 0.05 & (ttest_result$FC_HCC_divided_by_C >= 2 | ttest_result$FC_HCC_divided_by_C  <= 1/2), na.rm = TRUE)
# [1] 471


### C) Draw a Volcano plot and mark the proteins with a significant p-value after
### FDR-correction in a different colour. For this, use the VolcanoPlot_ttest()
### function from the ProtStatsWF package. A look at the help page of this function
### will be helpful.

VolcanoPlot_ttest(RES = ttest_result,
                  columnname_p = "p",
                  columnname_padj = "p.fdr",
                  columnname_FC = "FC_HCC_divided_by_C")



### D) As an alternative, we can calculate the limma test now. To be comparable
### with the t-test results, we only want to calculate it for proteins with
### a valid p-value for the t-test:
D_limma <- D[!is.na(ttest_result$p), ]


### load the limma package and perform the limma test.
library(limma)

### Apply the limma test. To mimick the paired t-test, add the sample variable
## as a blocking factor in the design matrix (~ group + sample).

design <- model.matrix(~ group + sample)
fit  <- lmFit(D_limma, design)
efit <- eBayes(fit)

limma_result <- topTable(efit, coef = "groupHCC", number = Inf, sort.by = "none")


### E) Create a Volcano Plot using the limma results. Be careful, as the
### limma result has different column names and the fold change columns is
### already log-transformed! Use the VolcanoPlot_ttest() function again and
### set the settings accordingly.

VolcanoPlot_ttest(RES = limma_result,
                  columnname_p = "P.Value",
                  columnname_padj = "adj.P.Val",
                  columnname_FC = "logFC",
                  is_FC_log = TRUE)


### F) Compare the results (Volcano plot, number of significant proteins, histogram
### of p-values).

sum(limma_result$P.Value <= 0.05, na.rm = TRUE) # [1] 1178
sum(limma_result$adj.P.Val <= 0.05, na.rm = TRUE) # [1] 992
sum(limma_result$adj.P.Val <= 0.05 & (limma_result$logFC >= 1 | limma_result$logFC  <= -1), na.rm = TRUE) # [1] 603

par(mfrow = c(2,2))
hist(ttest_result$p, 20, ylim = c(0, 1300))
hist(ttest_result$p.fdr, 20, ylim = c(0, 1300))
hist(limma_result$P.Value, 20, ylim = c(0, 1300))
hist(limma_result$adj.P.Val, 20, ylim = c(0, 1300))
par(mfrow = c(1,1))


### G) (optional) Use the ggVennDiagram package to visualize the overlap of
### significant proteins between the t-test and limma results.
### Have alook at this website for further information and example code
### for the ggVennDiagram package: https://gaospecial.github.io/ggVennDiagram/
## and the help page of the ggVennDiagram() function.

library(ggVennDiagram)
library(ggplot2)

ind_ttest <- which(ttest_result$p.fdr <= 0.05 & (ttest_result$FC_HCC_divided_by_C >= 2 | ttest_result$FC_HCC_divided_by_C  <= 1/2))
ind_limma <- which(limma_result$adj.P.Val <= 0.05 & (limma_result$logFC >= 1 | limma_result$logFC  <= -1))
X <- list(
    ttest = rownames(ttest_result)[ind_ttest],
    limma = rownames(limma_result)[ind_limma]
)
ggVennDiagram(X) + scale_fill_gradient(low="grey90",high = "red")



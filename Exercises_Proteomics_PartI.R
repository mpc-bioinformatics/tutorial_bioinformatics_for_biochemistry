# **General hints:**
#
# * Have a look at the slides again to solve the exercises.
# * Write down your code in an editor (e.g. the upper left window of RStudio).
# * Also look at the help pages of the mentioned R functions.
# * Exercises marked with a star (*) are more advanced and challenging and meant
# * for people who are quick or have already experience with R. If you no experience with R yet,
# please skip these exercises first and only do them if you have time left.


## Exercise 1: Pocket calculator
## Open R and use it as *pocket calculator* for the following tasks:

# 10 + 5
#
# 1 / 2
#
# (3 + 5) * 2
#
# 3 + 5 * 2
#
# 3 + 5 ^ 2
#
# and 100 / 0.




## Exercise 2: Variables

## A) Generate a variable x with value 2 and one variable y with value 5. Then
## compute the following expressions:
## - the sum of x and y
## - the logarithm to base 10 of (x times y)
## - y to the power of x


## B) Choose some of the functions mentioned in the script and use ``?`` or
## ``??`` to learn more about them.



## Exercise 3: Vectors

## A) Create a vector x containing the numbers 5, 2, 4, 6 and 43.


## B) Set the third element of x to 10.


## C) Replace the last element of the vector by its negative value and print the
## modified vector x into the console using the function ``print()``.





## Exercise 4: Data frames

# A) Create a data.frame with the following
# content:

# Type       Diameter   Height   Age
# --------  ---------  -------  ----
# Oak              57     15.7    29
# Beech            38     12.1    18
# Birch            23      8.5    10
# Chestnut         63     17.3    27
# Beech            41     15.1    21



## B) Index the data in order to obtain the diameters of the trees.



##  C) Index the data in order to obtain the information on beeches.




## D) Index the data in order to find information on trees that are 20 years or older.



## E) Index the data to find the height of trees that are 20 years or older.







## * (Optional): Exercise 5: Working with data

## Have a look at the help page of the function read.csv.
## Import the two data sets proteins_HCC.csv and clinical_data.csv which are located in the Data folder.

## Explore the data and answer the following questions:

# - How many proteins were measured?
# - What is the average protein length?
# - Which protein has the highest intensity in sample C_1?
# - Which protein has the highest mean intensity over all samples (hint: have a look at the function rowMeans())
# - How many and which proteins do NOT stem from homo sapiens? Why were they in the samples?

# - How many samples and patients do we have here and what kind of experimental groups?
# - How many is the distribution of men and woman? (hint: have a look at the table() function)


setwd("partI")






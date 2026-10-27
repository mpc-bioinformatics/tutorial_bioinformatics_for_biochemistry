
#### R COURSE

################################################################################
#### PART Ia


#### R as a pocket calculator ####

1 + 3
6 / 2 # This is a comment (after ‘#’)
7 - 3 * 2
0 / Inf
0 / 0 # not defined -> NaN (not-a-number)
1.5 + 2.7
sqrt(9)



#### Save numbers as objects ####

# assignment, expression is evaluated
a.sum <- 3 + 5
# assignment of object value
a_number <- 4
# immediate printing of evaluated expr.
a.sum + a_number
a.sum / 2
# assignment of evaluated expression
difference <- a.sum - a_number
# printing of object value
difference


#### Listing and removing objects ####

ls()

rm("a.sum")
a.sum

rm(list = ls())


q()



#### Help ####

help.start()
# help.search(<keyword>) or
# ??<keyword>
# show all help pages for <keyword>
help.search("t-test")
??"t-test"
# help(<function>) help on a function
# (exact name)
help(t.test)
# ?<function>, e.g.
?t.test
# browse package vignettes
browseVignettes(package="limma")



#### basic operators and functions ####

2^10

abs(-5)

sqrt(4)

round(3.14159, 2)
floor(3.14159)
ceiling(3.14159)

sin(pi/2)
cos(pi/2)
tan(pi/2)

log10(1000)

exp(1)

x <- Inf

y <- NA

z <- NaN

i <- NULL



#### vectors ####

x <- c(1.3, 7.4, 3.25)
x <- c(4.9, x, 3.95)

length(x)
sum(x)
min(x)
max(x)

x*2
x^2

log(x)




y <- c(TRUE, FALSE) # logical
z <- c("Alpha", "Bravo", "Charlie") # character


c(4, 3, y)

c("Alpha", 3, TRUE)

x <- as.character(x)
sum(x)

x <- as.numeric(x)
sum(x)



#### indexing vectors ####


x[3] # single entry

x[1:3] # set of entries`

x[c(1,3,12)]

x[-1] # exclude single entry via ’-’

x[-(1:3)] # exclude set of entries

x[-c(1,3,12)] # exclude set of entries

x[x<4] # entries meeting a logical condition

index <- x>=16
x[index]



#### sequences and repetitions ####

# 1:10
#
# x <- seq(1, 10, by=2)
# x
#
# seq(along = x)
#
#
# rep(1, 10)
#
# rep(x, each = 3)
#
# rep(5:9, each=2)



#### matrices ####

# matrix(data = NA, nrow = 1, ncol = 1,
#        byrow = FALSE, dimnames = NULL)
#
#
# X <- matrix(c(4, 2, 5, 7, 1, 6), nrow = 3, byrow = TRUE)
# X
#
#
# Y <- matrix(c(3, 5, 6, 2, 4, 1),
#             ncol = 3, byrow = TRUE)
# Y
#
#
#
# ncol(Y)
# nrow(Y)
# t(Y)
#
#
#
# matrix(1:9, ncol = 3, byrow = TRUE)
#
# matrix(1:9, ncol = 3, byrow = FALSE)




#### data frames ####

Z <- data.frame("Gender" = c("f","f","m","f","m"),
                "Age" = c(10,9,10,8,9),
                "Height" = c(120,118,104,109,111))


dimnames(Z)

rownames(Z)
colnames(Z)

head(Z,2)
tail(Z,2)



#### indexing data frames or matrices ####
#
# Y[2,1] # 2nd row, 1st column
#
# Y[1,] # complete 1st row
# Y[,1]
#
# Y[1:2,c(1,3)]


# selection by column name
Z[,1]
Z[1,]

Z[,"Gender"]

Z$Gender


### logic ans related functions ####

4 <= 1

6 == 3*2

(4 <= 1) && (6 == (3 * 2))

(4 >= 1) && (6 == (3 * 2))


c(TRUE, TRUE) & c(FALSE, TRUE)

FALSE || TRUE

(4 <= 1) || (6 == (3 * 2))


FALSE + TRUE + TRUE # TRUE = 1, FALSE = 0



any(c(TRUE, FALSE))
all(c(TRUE, FALSE))
which(c(TRUE, FALSE))
sum(c(TRUE, FALSE))


sum(x < 4)


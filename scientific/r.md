# R

<script type="text/javascript" src="../js/general.js"></script>

###Matrix related
---

* combine data

```R
missCount <- rnorm(100, mean=2, sd=0.5)
missPercent <- missCount/(colCount-2)
missDataStatus <- rbind(missCount,missPercent)
missDataStatus.2 <- cbind(missCount,missPercent)
```

* get row names and col names

```R
getOriData <- read.table("modified_data",header=T,sep="\t")
rowName <- rownames(getOriData)
colName <- colnames(getOriData)
```

* row and column counts

```R
getOriData <- read.table("modified_data",header=T,sep="\t")
rowCount <- nrow(getOriData)
colCount <- ncol(getOriData)
```

* type transformation into matrix

```R
# method.1
X <- c(1,2,3)
Y <- c(4,5,6)
Z <- as.matrix(rbind(X,Y))

# method.2
new_matrx <- matrix(
  rnorm(100, mean=4, sd=1),
  nrow = 10,
  ncol = 10
)
```

* transpose matrix by " t() "

```R
transZ <- t(Z)
```
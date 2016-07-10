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

###Loop
---

| api | desc |
| -- | -- |
| for(i in 1:100) { ... } | for loop with setp 1 |
| while(a == "same") { ... } | while loop with condition |
| for(i in seq(1,101,by=10)) { ... } | foreach loop |

###Branch
---

| api | desc |
| -- | -- |
| is.numeric(number) | is numeric |
| is.matrix(matrix) | is matrix |

* if else

```R
if() { ... }
else if() { ... }
else { ... }
```

* try catch

```R
tryCatch(
	res <- as.numeric(input),
	warning = function(w) { ... },
	error = function(e) { ... },
	finally { ... }
)
```

###System Interaction
---

* system parameters

```R
# trailingOnly = TRUE/FALSE to show all default parameters
sysArgs <- commandArgs(trailingOnly = TRUE)
```

* start from index 1

```R
for(i in 1:length(sysArgs)) { ... }
```

###Set theory
---

| api | desc |
| -- | -- |
| ttlUnion <- union(A, B) | union |
| ttlIntersection <- intersect(A, B) | intersect |
| ttlDiff <- setdiff(A, B) | A-B |
| ttlEqual <- setequal(A, B) | A == B |
| if(is.element("abc",C)) | abc in set.C |
| if(ele %in% A) | element in set.A |


###File I/O
---

* write a text file

```R
sink("out.txt", append = TRUE)
cat( ... )
sink()
```




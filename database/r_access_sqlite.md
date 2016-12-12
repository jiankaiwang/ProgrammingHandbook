# R access SQLite

<script type="text/javascript" src="../js/general.js"></script>

### Necessary Packages
---

```r
install.packages("Rcpp")
install.packages("sqldf")
install.packages("XLConnect")
```

### Simple Example : Output all tables in CSV format
---

```r
# import package
library(sqldf)

# connect the database
db <- dbConnect(SQLite(), dbname="ht.sqlite")

# list all tables
allTables = dbListTables(db)

# output all tables in csv format
for(i in 1:length(allTables)) {
  tryCatch({
    data <- dbReadTable(db, allTables[i])
    write.table(data, file = paste(allTables[i],"csv",sep="."), 
      append = FALSE, quote = FALSE, sep = ",",
      eol = "\n", na = "NA", dec = ".", row.names = FALSE,
      col.names = FALSE, qmethod = c("escape", "double"),
      fileEncoding = "")
  }, error = function(e) {
    print(allTables[i])
  })
}
```
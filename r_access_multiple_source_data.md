# R access multiple source data
###目前測試過的來源如下
*  txt (純文字檔，含以 Tab 分隔檔案)
*  csv (以逗號分隔檔案)
*  mdb, accdb (access)
*  SQL Server (微軟伺服器為主資料庫)
*  xlsx (Excel 2007 以上版本)
*  json (網頁資料交換格式)
*  xml (網頁資料交換格式)
*  MySQL (Oracle 伺服器資料庫)
*  SPSS (統計軟體之一)
*  SAS (統計軟體之一)
*  HTML (網頁內容)

###程式碼如下
```javascript
var s = "JavaScript syntax highlighting";
# ----------
# Date: 2015/11/30
# Version: v.1.a
# Author: Wang, Jian-Kai (http://jiankaiwang.no-ip.biz/)
# Environment: Windows 7 64-bit, R-3.0.1 32-bit
# Description: Use R to read different sources, including EXCEL, SQL SERVER, MySQL, SAS
# ----------

# ----------
# READ & WRITE from or to a TXT(Tab) OR CSV(Comma) file
getTxtData <- read.table("xxx.txt",sep="\t",header = TRUE)
getCSVData <- read.table("xxx.csv",sep=",",header = TRUE)
calData <- cbind(as.numeric(getTxtData[,3]),as.numeric(getTxtData[,7]))
savData <- cbind(
  c("xxx","xxx"),
  c(mean(calData[1:181,1]),mean(calData[182:365,1])),
  c(mean(calData[1:181,2]),mean(calData[182:365,2]))
)
colnames(savData) <- c("date","ave_atom","ave_temp")
write.table(
  savData, 
  file="calTxt.txt", 
  quote=FALSE,
  sep="\t",
  col.names=TRUE,
  row.names=FALSE
)
write.table(
  savData, 
  file="calTxt.csv", 
  quote=FALSE,
  sep=",",
  col.names=TRUE,
  row.names=FALSE
)
# ----------

# ----------
# READ & WRITE ACCESS: .mdb, *.accdb format BY ODBC as Database
# First is to set ODBC on "control center"; Win 64 bit: C:\Windows\SysWOW64\odbcad32.exe
# fetched data is data.frame and data for inserting into the database must be data.frame
# even id is auto increment, it is necessary to prepare
install.packages("RODBC")
library(RODBC)
conn = odbcConnect("R2ACCESS")
#allTables <- sqlTables(conn)$TABLE_NAME

# analyze data
df = sqlFetch(conn, "cityData")
barplot(
  as.numeric(df[c(1,3,2),4]),
  names.arg=df[c(1,3,2),2],
  col=c("red","green","blue"),
  main="CITY POPULATION",
  xlab="CITY",
  ylab="POPULATION (10 thousand)", 
  legend.text = df[c(1,3,2),3],
)

# insert (or delete) a new data into access db
savData <- matrix(c("4","Kyoto","Japan","1335"),nrow=1)
colnames(savData) <- c("id","name","country","population")
savData <- as.data.frame(savData)
sqlSave(conn, savData, tablename="cityData", rownames=FALSE, append=TRUE, addPK=TRUE)

# update a record
upData <- matrix(c("4","Tokyo"),nrow=1)
colnames(upData) <- c("id","name")
upData <- as.data.frame(upData)
# index means the column for being updated
sqlUpdate(conn, upData, tablename="cityData", index="id")   

close(conn) # close the connection to the file
# ----------

# ----------
# READ SQL SERVER by RODBC
# must establish basic operation in SQL SERVER EXPRESS
install.packages("RODBC")
library(RODBC)

# method.1
# IP-address\SQLEXPRESS,Port is the format used to link the SQL Express
sqlHost <- "IP Address\\SQLEXPRESS,1433"   
sqlDatabase <- "2015_city_online"

# connection string.1 : using different web domains might go error
#dsnString <- "driver={SQL Server};server=%s;database=%s;trusted_connection=true;uid=test;pwd=test1234"

# connection string.2 : use 
# "Initial Catalog=cityData;Persist Security Info=True;" 
# to replace "trusted_connection=true;"
dsnString <- "driver={SQL Server};server=%s;database=%s;Initial Catalog=%s;Persist Security Info=True;uid=uid;pwd=pwd"

dsn <- sprintf(dsnString, sqlHost, sqlDatabase)
dbHandle <- odbcDriverConnect(dsn)

# method.2 : must operate firstly in Control Panel
dbHandle <- odbcConnect("R2SQLEXPR_2",uid="test",pwd="test1234")

# fetched data as data.frame
query <- "SELECT * FROM [Table]"
qyDF <- sqlQuery(dbHandle, query)

# insert a new data into the table
insertQuery <- "insert into [Table](name,country) values('Tokyo','Japan')"
insertDF <- sqlQuery(dbHandle, insertQuery)

# update a record
updateQuery <- "update [Table] set name='kyoto' where Id='4'"
updateDF <- sqlQuery(dbHandle, updateQuery)

# delete a record
deleteQuery <- "delete from [Table] where Id='19'"
deleteDF <- sqlQuery(dbHandle, deleteQuery)

odbcClose(dbHandle)
# ----------

# ----------
# READ EXCEL: .xlsx, .xls format by XLS package
# sheetIndex: start from 1
# data type: data.frame
# default: row 1 (index 0) as column name
install.packages("xlsx")
library(xlsx)
conXls <- read.xlsx("xxx.xls", sheetIndex = 1)
conXlsx <- read.xlsx("xxx.xlsx", sheetIndex = 1)
# write xlsx table (must be data.frame type)
savData <- cbind(conXls[,1],conXls[,2],conXls[,3])
colnames(savData) <- colnames(conXls)[1:3]
getWriteStatus <- write.xlsx(
                     savData, 
                     "ooo.xlsx", 
                     sheetName="weather", 
                     col.names=TRUE, 
                     row.names=FALSE, 
                     append=FALSE, 
                     showNA=TRUE
                   )
# ----------

# ----------
# READ JSON by rjson package
# fetched data is data.frame type
install.packages(c("jsonlite","curl"))
library(jsonlite)
library(curl)

# input JSON file as data.frame
loginJSONExample <- 'https://api.github.com/users/hadley/orgs'
transFromJson <- fromJSON(loginJSONExample,flatten = TRUE)

# output JSON text
savData <- toJSON(transFromJson[,1:3])
sink("login.json",append=TRUE)
cat(savData)
sink()
# ----------

# ----------
# READ & WRITE MySQL Database by DBI
# remember must open port in Linux
# set all host are accepted by following commands
# mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'WITH GRANT OPTION;   
# % means all hosts are accepted
# mysql> FLUSH PRIVILEGES;   # refresh memory
install.packages("DBI")
install.packages("RMySQL")
library(DBI)
library(RMySQL)
con <-  dbConnect( 
  RMySQL::MySQL(), 
  username = "user", 
  password = "password", 
  host = "IP address", 
  port = 3306, 
  dbname = "test" 
)

# fetch data as data.frame type
getMySQLData <- dbGetQuery(con, "SELECT * FROM cityData")

# insert data as data.frame type
savData <- matrix(c('shanghai','China'),nrow=1)
colnames(savData) <- c('name','country')
savData <- as.data.frame(savData)
getInsertMySQLStatus <- dbWriteTable(con, name="cityData", value=savData, field.types=list(name="varchar(75)",country="varchar(75)"), row.names=FALSE, append=TRUE)

# update data by doGetQuery function
updateQuery <- "update cityData set name='SHANGHAI' where id='4'"
getUpdateStatus <- dbGetQuery(con, updateQuery)

# delete data by doGetQuery function
deleteQuery <- "delete from cityData where id='4'"
getDeleteQuery <- dbGetQuery(con, deleteQuery)

dbDisconnect(con)
# ----------

# ----------
# READ SPSS File By foreign package
install.packages("foreign")
library("foreign")
getSPSSData <- read.spss("p004.sav", to.data.frame=TRUE)
# ----------

# ----------
# READ SAS File by sas7bdat package
install.packages("sas7bdat")
library("sas7bdat")
getSASData <- read.sas7bdat("help.sas7bdat", debug=FALSE)
# ----------

# ----------
# READ HTML
install.packages("RCurl")
install.packages("XML")
library("RCurl")
library("XML")

# method.1 get html content
doc <- "<html><body>This is some random text.<p>This is some text in a paragraph.</p><p>This is a statement which says that 2 < 3 = TRUE, 4 < 5 = TRUE and 10 > 9 = TRUE.</p></body></html>"
pattern <- "</?\\w+((\\s+\\w+(\\s*=\\s*(?:\".*?\"|'.*?'|[^'\">\\s]+))?)+\\s*|\\s*)/?>"
plain.text <- gsub(pattern, "\\1", doc)

# method.2
doc.html = htmlTreeParse('http://apiolaza.net/babel.html', useInternal = TRUE)
doc.text = unlist(xpathApply(doc.html, '//p', xmlValue))
doc.text = gsub('\\n', ' ', doc.text)

# method.3 analyze content by regular expression
html <- getURL("http://edition.cnn.com/", followlocation = TRUE)
doc <- htmlParse(html, asText=TRUE)
plain.text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
# ----------

# ----------
# READ XML as list (after xmlChildren() function)
# use index to access different nodes
install.packages("RCurl")
install.packages("XML")
library("RCurl")
library("XML")
getXMLData = xmlParse("http://IP-address:Port/example.xml")
root = xmlRoot(getXMLData)
child = xmlChildren(root)

# parsing method.1
getNode <- child$url   # url must be unique

# parsing method.2 by the index
allNodes <- child[1:length(child)]
allContents <- c()
for(i in seq(1,length(child),1)) {
  # allContents are also the list-type
  allContents <- c(allContents,child[i][[1]][[1]][[1]])
}

# write out xml stream
savXMLData = newXMLNode("city")

# node.1
detail <- newXMLNode("detail", parent = savXMLData)
newXMLNode("name", attrs = c(loc = 'asia'), 'Beijing', parent = detail)
newXMLNode("country", "China", parent = detail)

# node.2
detail <- newXMLNode("detail", parent = savXMLData)
newXMLNode("name", attrs = c(loc = 'america'), 'New York',parent = detail)
newXMLNode("country", "USA", parent = detail)

savXMLData   # end the XML

saveXML(
  savXMLData, 
  file="output.xml", 
  compression=0, 
  indent=TRUE, 
  prefix = '<?xml version="1.0"?>\n', doctype = NULL
)
# ----------
```




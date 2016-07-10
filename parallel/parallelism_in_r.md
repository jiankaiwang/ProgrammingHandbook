# Parallelism in R

<script type="text/javascript" src="../js/general.js"></script>

* Package : {parallel} 

###Background
---

* The {parallel} package in R script is the 'coarse-grained parallelization'. 

* There are several implementations of this model in the functions mclapply, parLapply as near-drop-in replacements for lapply. 

* The are many replacements for single computing commands, for example, parLapply vs. lapply, parRapply vs. apply(,1,), parCapply vs. apply(,2,), etc.

###global variable: rnames
---

* Global variable, named rnames, is used as the reference making parallel cluster fetch, calculate and modify the content.

```text
row.names             Proteins                  Sequence.window
        1               A0FGR8  LLASPGHISVKEPTPSIASDISLPIATQELR
        2               A1L390  SKSSGFGSPRLVSRSSSVLSLEGSEKGLARH
        3               O00505  RDEHLLKKRNVPQEESLEDSDVDADFKAQNV
        4               O00566  SPVFSDEDSDLDFDISKLEQQSKVQNKGQGK
        5               O00567  KPKKKKSFSKEELMSSDLEETAGSTSIPKRK
        6               O14646  KNGKKILGQKKRQIDSSEEDDDEEDYDNDKR
        7               O14646  NGKKILGQKKRQIDSSEEDDDEEDYDNDKRS
        8               O14745  LAEAALESPRPALVRSASSDTSEELNSQDSP
        9               O14745  ESPRPALVRSASSDTSEELNSQDSPPKQDST
       10 P19105;P24844;O14950  KRTKTKTKKRPQRATSNVFAMFDQSQIQEFK
       11               O14974  SKEGQKEKDTAGVTRSASSPRLSSSLDNKEK
       12               O14974  SDENEQEQQSDTEEGSNKKETQTDSISRYET
       13               O15047  PSEISEASEEKRPRPSTPAEEDEDDPEQEKE
       14               O43318  IQDLTVTGTEPGQVSSRSSSPSVRMITTSGP
       15               O43379  LPSVMAGVPARRGQSSPPPAPPICLRRRTRL
       16               O43719  EDDDSNEKLFDEEEDSSEKLFDDSDERGTLG
       17               O43719  KKAEEGDADEKLFEESDDKEDEDADGKEVED
       18               O60231  EKNRSYRLLEDSEESSEETVSRAGSSLQKKR
       19               O60271  AGLDTEGSKQRSASQSSLDKLDQELKEQQKE
       20               O60293  RKWKPKFWRKPISDNSFSSDEEQSTGPIKYA
```

###Result storage
---

* Variable, rowExtract, is used as the storage of results from each clusters executing parallel computing. The following is the original content of rowExtract.

```R
row.names	V1	V2	V3
        1	X1	X1	X1
        2	X3	X3	X3
        3	X5	X5	X5
        4	X8	X8	X8
        5	X9	X9	X9
        6	X10	X10	X10
        7	X11	X11	X11
        8	X13	X13	X13
        9	X15	X15	X15
        10	X16	X16	X16
        11	X17	X17	X17
        12	X18	X18	X18
        13	X19	X19	X19
        14	X20	X20	X20
```

###Core code using {parallel}
---

* Use function getSepRowInfo to fetch each row content of rowExtract and then extract number, e.g. 1,3,5. Further, use number to map the row.names of rnames and then fetch corresponding its protein session name and sequence. Use the function, transpose of matrix, to modify the result into current format.

```R
getSepRowInfo <- function(data) {
	#rowExtract <<- rbind(rowExtract, rnames[as.numeric(substr(data,2,nchar(data))),1:2])
	currentData <- data[1]
	numberInData <- as.numeric(substr(data[1],2,nchar(data[1])))
	data[2] <- rnames[numberInData,1]
	data[3] <- rnames[numberInData,2]
	return(data)
}

# mclapply could not execute under windows system due to forking issues
#mclapply(get_fill_info,getSepRowInfo,
#	mc.silent = FALSE,
#	mc.cores = getOption("mc.cores", 1),
#	mc.cleanup = TRUE, mc.allow.recursive = TRUE)

# another method for parallel computing
# create two computing clusters
cl <- makeCluster(mc <- getOption("cl.cores", 2))

# use global variables rnames, this action must be exectued
clusterExport(cl=cl, varlist=c("rnames"))

# start to execute parallel computing by row unit of the matrix
rowExtract <- parRapply(cl,rowExtract,getSepRowInfo)

# transform data because results from parallel computing are 'list' and then concatenate
rowExtract <- t(matrix(rowExtract,nrow=3))

# stop the cluster created
stopCluster(cl)
```


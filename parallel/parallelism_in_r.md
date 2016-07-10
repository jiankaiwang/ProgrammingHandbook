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
row.names	Proteins	Sequence.window
1	A0FGR8	LLASPGHISVKEPTPSIASDISLPIATQELR
2	A1L390	SKSSGFGSPRLVSRSSSVLSLEGSEKGLARH
3	O00505	RDEHLLKKRNVPQEESLEDSDVDADFKAQNV
4	O00566	SPVFSDEDSDLDFDISKLEQQSKVQNKGQGK
5	O00567	KPKKKKSFSKEELMSSDLEETAGSTSIPKRK
6	O14646	KNGKKILGQKKRQIDSSEEDDDEEDYDNDKR
7	O14646	NGKKILGQKKRQIDSSEEDDDEEDYDNDKRS
8	O14745	LAEAALESPRPALVRSASSDTSEELNSQDSP
9	O14745	ESPRPALVRSASSDTSEELNSQDSPPKQDST
10	P19105;P24844;O14950	KRTKTKTKKRPQRATSNVFAMFDQSQIQEFK
11	O14974	SKEGQKEKDTAGVTRSASSPRLSSSLDNKEK
12	O14974	SDENEQEQQSDTEEGSNKKETQTDSISRYET
13	O15047	PSEISEASEEKRPRPSTPAEEDEDDPEQEKE
14	O43318	IQDLTVTGTEPGQVSSRSSSPSVRMITTSGP
15	O43379	LPSVMAGVPARRGQSSPPPAPPICLRRRTRL
16	O43719	EDDDSNEKLFDEEEDSSEKLFDDSDERGTLG
17	O43719	KKAEEGDADEKLFEESDDKEDEDADGKEVED
18	O60231	EKNRSYRLLEDSEESSEETVSRAGSSLQKKR
19	O60271	AGLDTEGSKQRSASQSSLDKLDQELKEQQKE
20	O60293	RKWKPKFWRKPISDNSFSSDEEQSTGPIKYA
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




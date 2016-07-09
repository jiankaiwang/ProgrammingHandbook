# C++

<script type="text/javascript" src="../js/general.js"></script>

###Arithmetic functions
---

| 宣告 | 說明/例子 | 標頭檔 |
| -- | -- | -- |
| int abs(int); | int res = abs(-1); //res = 1  | cstdlib |
| long labs(long); | long res = labs(-2); //res = 2 | cstdlib |
| double fabs(double); | 返回 double 的絕對值 | cmath |
| double sqrt(double); | 取得傳入值的平方根 | cmath |
| double pow(double,double);  | double res = pow(4.0,2.0); // res = 16 | cmath |
| double exp(double); | double res = exp(2.0); //res = 7.389 | cmath |
| double log(double); | 返回 $$log_{e}$$ 的值| cmath |
| double log10(double); | 返回 $$log_{10}$$ 的值 | cmath |
| double ceil(double); | 返回最接近的大整數<br>double res = ceil(-1.2); //res = -1.0;  | cmath |
| double floor(double); | 返回最接近的小整數<br>double res = floor(-1.2); //res = -2.0;  | cmath |

###檔案 I/O 成員函式
---

| 宣告 | 說明/例子 | 標頭檔 |
| -- | -- | -- |
| stream_var.open(); | 串流輸入輸出的開啟<br>fin.open(); fout.open(); | fstream |
| stream_var.fail(); | 搭配 .open() 使用<br>return true 當串流開啟失敗 | fstream / iostream |
| stream_var.close(); | 關閉串流 | fstream / iostream |
| \*stream_var.bad(); | stream_var 為 corrupted 時為 true | fstream / iostream |
| stream_var.eof(); | 用預讀下一個字來判別是否為 stream_var 結束。 | fstream / iostream |
| stream_var.get(char_varable); | 從 stream_var 讀入一個字元<br>存於 char_variable 中 | fstream / iostream |
| stream_var.getline(string_variable, max_char+1);| 從 stream_var 讀入一行字串，讀入長度為 max_char+1  | fstream / iostream |
| 0:9 | 1:9 | fstream / iostream |
| 0:10 | 1:10 | fstream / iostream |
| 0:11 | 1:11 | fstream / iostream |
| 0:12 | 1:12 | fstream / iostream |
| 0:13 | 1:13 | fstream / iostream |
| 0:14 | 1:14 | fstream / iostream |
| 0:15 | 1:15 | fstream / iostream |
| 0:16 | 1:16 | fstream / iostream |
| 0:17 | 1:17 | fstream / iostream |




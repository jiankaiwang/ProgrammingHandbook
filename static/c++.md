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
| double ceil(double); | 返回最接近的大整數double res = ceil(-1.2); //res = -1.0;  | cmath |
| double floor(double); | 返回最接近的小整數double res = floor(-1.2); //res = -2.0;  | cmath |

###檔案 I/O 成員函式
---

| 宣告 | 說明/例子 | 標頭檔 |
| -- | -- | -- |
| stream_var.open(); | 串流輸入輸出的開啟fin.open(); fout.open(); | fstream |
| stream_var.fail(); | 搭配 .open() 使用return true 當串流開啟失敗 | fstream / iostream |
| stream_var.close(); | 關閉串流 | fstream / iostream |
| \*stream_var.bad(); | stream_var 為 corrupted 時為 true | fstream / iostream |
| stream_var.eof(); | 用預讀下一個字來判別是否為 stream_var 結束。 | fstream / iostream |
| stream_var.get(char_varable); | 從 stream_var 讀入一個字元存於 char_variable 中 | fstream / iostream |
| stream_var.getline(string_variable, max_char+1);| 從 stream_var 讀入一行字串，讀入長度為 max_char+1  | fstream / iostream |
| stream_var.peek();  //return char | 預先讀一個字，但讀完又放回去，用 get 仍可讀這個字，可用於欲讀判斷  | fstream / iostream |
| stream_var.put(char_exp); | 將 char 放入 stream_var 中，可顯示或輸出檔案 | fstream / iostream |
| stream_var.clear(); | 清除 stream_var 讀取指標 | fstream / iostream |
| stream_var.seekg(int_pos); | 移動讀取指標到那個位置  如 0 或 ios::beg 表示初始 | fstream / iostream |
| stream_var.putback(char_exp); | 改變下一個要讀入的 char 成剛 putback 的 char | fstream / iostream |
| stream_var.precision(int_exp);  //cout.precision(4);  //cout << 100.12345 << endl;  | 設定數字輸出的精確度達幾位，含整數(先)與小數(後)。 //輸出  100.1 | fstream / iostream |
| stream_var.width(int_exp); | 設定用多少寬度來表示輸出 (靠右顯示) | fstream / iostream |
| stream_var.setf(Flag); | 依旗標來調整輸入輸出格式如 ios::showpoint 小數點ios::fixed 顯示精確位小數點 | fstream / iostream |
| stream_var.unsetf(Flag); | 將輸入輸出 Flag 設定取消 | fstream / iostream |

###Character Functions 
---

| 宣告 | 說明/例子 | 標頭檔 |
| -- | -- | -- |
| bool isalnum(char); | isalpha 或 isdigit 成立為 T 其餘為 F | cctype |
| bool isalpha(char); | 字母(大小寫皆可)為 T，其餘 F | cctype |
| bool isdigit(char); | 數字為 T，其餘 F | cctype |
| bool ispunct(char); | 可印出且非 isalnum 且非 whitespace 為 T，其餘 F | cctype |
| bool isspace(char); | whitespaces 為 T，其餘 F | cctype |
| bool iscntrl(char); | control character 為 T，其餘 F | cctype |
| bool islower(char); | 小寫字母為 T，其餘 F | cctype |
| bool isupper(char); | 大寫字母為 T，其餘為 F | cctype |
| int tolower(char); | 回傳小寫的 ascii code number | cctype |
| int toupper(char); | 回傳大寫的 ascii code number | cctype |

###C-String functions 
---

| 宣告 | 說明/例子 | 標頭檔 |
| -- | -- | -- |
| int atoi(const char a[]); | 將 c-string array 轉成 int | cstdlib |
| long atol(const char a[]); | 將 c-string array 轉成 long | cstdlib |
| double atof(const char a[]); | 將 c-string array 轉成 double | cstdlib |
| (void) strcat(c-string_var, c-string_exp); | 將 c-string_exp 的內容接在c-string_var 後，沒有長度檢查 | cstring |
| (bool) strcmp(c-string_var1,c-string_var2); | 比較兩個字串是否不同，傳 T，是不同；傳回 F，相同 | cstring |
| (void) strcpy(c-string_var, c-string_exp); | 將 c-string_exp 的內容一併複製到 c-string_var，沒有長度檢查 | cstring |
| (int) strlen(c-string_exp); | c-string 長度(個數)，不含 ‘\0’ | cstring |
| (void) strncat(c-string_var, c-string_exp, limit); | 從 c-string_exp，中取出 limit長度來接在 c-string_var 後面 | cstring |
| (bool) strncmp(c-string_var, c-string_exp, limit) | c-string_exp 前 limit 個字來跟 c-string_var  比較是否不同 | cstring |
| (void) strncpy(c-string_var, c-string_exp, limit) | c-string_exp 中取出 limit 個字複製到 c-string_var | cstring |
| (void\*) strstr(c-string_var, pattern); | pattern 是否在 c-string_var中，回傳 null 為沒有(可用bool 來檢測)，若有回傳pointer，顯示相同字串 | cstring |
| (void\*) strchr(c-string_var, char); | 檢查 character 在 c-string_var 中的位置，顯示之後字串，回
傳 null 為沒有(可用 bool 來檢測) | cstring |
| (void\*) strrchr(c-string_var, char) | 檢查 character 在 c-string_var 中最後的位置，顯示之後字串，回傳  null 為沒有(可用 bool 來檢測) | cstring |
| 0:15 | 1:15 | cstring |







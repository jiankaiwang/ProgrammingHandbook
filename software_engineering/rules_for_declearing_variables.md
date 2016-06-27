# rules for declearing variables

<script type="text/javascript" src="../js/general.js"></script>

變數名稱宣告一直以來都是討論的議題之一，而變數宣告對於軟體維護有著重要的地位，底下提出數個變數宣告的方法。

###匈牙利命名法(Hungarian notation)
---

```text
變數名稱 = 屬性 + 類型 + 描述
```

* 屬性 :

| 屬性 | 說明 |
| -- | -- |
| g | global (全域變數) |
| c | constant (常數) |
| m | member (類別成員變數) |

* 類型 : 

| 類型 | 說明 |
| -- | -- |
| n | int |
| l | long |
| sh | short |
| f | float |
| d | double |
| ld | long double |
| c | char |
| b | boolean |
| p | pointer |
| h | handle |
| fn | function |

* 範例 : 

| 範例 | 變數宣告 |
| -- | -- |
| 一整數名為總和的全域變數 | gnSum |
| 一小數點名為標準的常數 | cdStandard |

* 此命名法遇到的幾個問題：
  1. 冗餘的寫法 : 如下例，已清楚知道 strcpy 傳入的資料型態

```Cpp
strcpy(pstrCpInfo,pcstrTpInfo) or strcpy(CpInfo,TpInfo)
```

###駱駝命名法(Camel-Case notation)
---







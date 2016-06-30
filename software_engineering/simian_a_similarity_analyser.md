# Simian : a similarity analyser

<script type="text/javascript" src="../js/general.js"></script>

###目的
---

* 找出高度重複的程式碼片段，如不同 class 中類似功能，但可以整併在一起，提供未來重構的重要資訊。

###簡介
---

* 支援多種中高階程式語言，如 C++, Java, C#, Ruby, ASP, HTML, XML, COBOL, ... 等。

###授權
---

Simian 的授權依照不同的使用狀況而有差異，如下：

* Licences for Non-Commercial Projects and Evaluation : 對於非商業的免費軟體或開源組織，提供免費的軟體授權。

* Personal/SOHO License : 個人使用者，僅能使用在一台機器上，不能產生報表，但提供技術支援及數項功能更新，但不包含下一個版本的主要功能。

* Project/Build Server License :　允許使用在不同機器上或是一台機器上不同專案，提供電話或是信件的支援。

* Enterprise and other Licenses : 大型組織使用，允許使用在很多機器的不同專案中。也可以視狀況洽談不同的授權內容。

###啟用 Simian
---

* Simian 支援兩種環境，Java 與 .NET 環境。

```Bash
# java 環境下使用
java -jar simian.jar [options] [files]
```

```Bash
# .NET 環境下使用
simian.exe [options] [files]
```

###使用 Simian
---

```Bash
# 比對兩個檔案
java -jar simian.jar <file1> <file2>

# 比對資料下所有 java 檔案
java -jar simian.jar <path/*.java>
```






# TypeScript

由於 JavaScript 的語法 (嚴格來講是 ECMAScript 262 3/e 或 5/e) 在 data type (資料型別) 上一直是一個令人詬病的問題，此與動態繫結 (Dynamic binding) 有直接關係，而一直以來有許多的 project 嘗試要去解決這問題，如 GWT (Google Web Kit，Java 延伸) 或是 Script# (C# 延伸)，而後透過各自的編譯器（compiler）來產出 JavaScript 程式碼。<br>
但 TypeScript 強項則是「能直接支援原生 Javascript」，所以能幾乎保留原始的 Javascript 的函式庫。

###安裝 TypeScript
---
[官方網站(連結)](http://www.typescriptlang.org/)說明數種下載與安裝方式；
* 透過 node.js 安裝 : 啟動 「node.js command prompt」，並輸入下列指令；

```node.js
$ npm install -g typescript
```

* 直接下載可以安裝於 Microsoft Visual Studio 的版本

###前言：可以支援原生 Javascript
---
因 Typescript 可以完全支援 Javascript，可以不用修改任何 .js code 或是 Javascript-based Coding 方式，如下；

```Javascript
function greeter(person) {
    return "Hello, " + person;
}

var user = "Jane User";

document.body.innerHTML = greeter(user);
```

然後直接透過 TypeScript 編譯器進行編譯即可。

###如何進行 TypeScript 開發與編譯
---
* 先開啟文件並儲存下列程式碼，附檔名為 **.ts**。

```Typescript
interface Person {
    firstname: string;
    lastname: string;
}

// person 為變數，而 Person 為自定義資料型態 (以物件方式)
function greeter(person : Person) {
    return "Hello, " + person.firstname + " " + person.lastname;
}

var user = {firstname: "Jane", lastname: "User"};

document.body.innerHTML = greeter(user);
```

上述程式碼說明如下：
* TypeScript 中定義資料型別方式為 (變數名稱):(資料型態，可為自定義類別)
* 其中 Person 定義靜態資料型別，內包含兩個成員，firstname 與 lastname。
* greeter 定義一個函式，將剛已定義 person 資料型別作為參數帶入，此函式將 person 物件中的 firstname 與 lastname 進行串接並回傳一個字串。
* var user 則是創建一個以 Person 資料類別作為模版的物件，並初始化該成員變數。
* document.body.innerHTML 則是顯示出函式 greeter 的結果。

* 將上列程式碼儲存後，儲存成 「example.ts」 放置於桌面 (舉例路徑：C:\Users\JianKaiWang\Desktop\example.ts)

* 啟動 「node.js command prompt」，然後透過 TypeScript 編譯器 (tsc) 進行編譯，如下；(編譯完成後會產生一個 **.js** 檔案，檔名為 「example.js」)

```Bash
$ tsc C:\Users\JianKaiWang\Desktop\example.ts
```

* 而產生出來的 example.js (預設與 .ts 檔案放置在相同路徑) 如下

```Javascript
function greeter(person) {
    return "Hello, " + person.firstname + " " + person.lastname;
}
var user = { firstname: "Jane", lastname: "User" };
document.body.innerHTML = greeter(user);
```















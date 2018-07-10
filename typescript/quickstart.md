# Quick Start





## 安裝 TypeScript

[官方網站(連結)](http://www.typescriptlang.org/)說明數種下載與安裝方式；

- 透過 node.js 安裝 : 啟動 「node.js command prompt」，並輸入下列指令；

```node.js
$ npm install -g typescript
```

- 直接下載可以安裝於 Microsoft Visual Studio 的版本



## 前言：可以支援原生 Javascript

因 Typescript 可以完全支援 Javascript，可以不用修改任何 .js code 或是 Javascript-based Coding 方式，如下；

```javascript
function greeter(person) {
    return "Hello, " + person;
}

var user = "Jane User";

document.body.innerHTML = greeter(user);
```

然後直接透過 TypeScript 編譯器進行編譯即可。



## 如何進行 TypeScript 開發與編譯

- 先開啟文件並儲存下列程式碼，附檔名為 **.ts**。

```typescript
// Person 為自定義資料型態 (以結構方式，類似 C 或 C++ 中的 struct)
interface Person {
    firstname: string;
    lastname: string;
}

// person 為變數，而其資料型態為 Person
function greeter(person : Person) {
    return "Hello, " + person.firstname + " " + person.lastname;
}

var user = {firstname: "Jane", lastname: "User"};

document.body.innerHTML = greeter(user);
```

上述程式碼說明如下：

- TypeScript 中定義變數的資料型態方式為 **(變數名稱):(資料型態，可為自定義類別)**
- 其中 Person 定義靜態資料型別，內包含兩個變數，firstname 與 lastname，且資料型態皆為 string
- TypeScript 中透過 **interface** 來描述(定義)一個結構
- greeter 定義一個函式，將剛已定義 person 資料型別作為參數帶入，此函式將 person 結構中的 firstname 與 lastname 進行串接並回傳一個字串。
- var user 則是創建一個以 Person 資料結構作為模版的物件，並初始化此結構中的變數。
- document.body.innerHTML 則是顯示出函式 greeter 的結果。
- 將上列程式碼儲存後，儲存成 「example.ts」 放置於桌面 (舉例路徑：C:\Users\JianKaiWang\Desktop\example.ts)
- 啟動 「node.js command prompt」，然後透過 TypeScript 編譯器 (tsc) 進行編譯，如下；(編譯完成後會產生一個 **.js** 檔案，檔名為 「example.js」)

```bash
$ tsc C:\Users\JianKaiWang\Desktop\example.ts
```

- 而產生出來的 example.js (預設與 .ts 檔案放置在相同路徑) 如下

```javascript
function greeter(person) {
    return "Hello, " + person.firstname + " " + person.lastname;
}
var user = { firstname: "Jane", lastname: "User" };
document.body.innerHTML = greeter(user);
```



## 資料型態的註解 (Type annotation)

在 TypeScript 中可以透過 **(變數名稱):(資料型態)** 方式來對使用的變數進行資料型態的繫結，也因此在進行 TypeScript Compile 中，會針對資料型態進行檢查，如下範例；

```typescript
function greeter(person: string) {
    return "Hello, " + person;
}

var user = [0, 1, 2];

// 在 typescript 進行 compile 時會出現錯誤
document.body.innerHTML = greeter(user); 
```

當使用 greeter 函式時，會將資料型態為 list 的變數傳入只能接受來自 string 的 greeter 函式，此時 compiler 會發覺資料型態上的錯誤而出現 error，如下，

```bash
greeter.ts(7,26): Supplied parameters do not match any signature of call target
```



## 定義介面(Interface, 結構)

TypeScript 中透過 interface 來定義一個結構，此結構內包含數個不同型態的變數，此類似於 C 或 C++ 中定義 struct 的方式。<br>
此外，可以經由一個 dictionary 變數來初始化透過此結構產生的變數，如上述範例；

```typescript
interface Person {
    firstName: string;
    lastName: string;
}

function greeter(person: Person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}

var user = { firstName: "Jane", lastName: "User" };

document.body.innerHTML = greeter(user);
```



## 定義類別 (Class)

此定義方式將原本 Javascript 中雜亂的結構化資料型態進行處理。如下方的 Student 類別；

```typescript
class Student {
    fullName: string;
    constructor(public firstName, public middleInitial, public lastName) {
        this.fullName = firstName + " " + middleInitial + " " + lastName;
    }
}

interface Person {
    firstName: string;
    lastName: string;
}

function greeter(person : Person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}

var user = new Student("Jane", "M.", "User");

document.body.innerHTML = greeter(user);
```

上面 Student 類別中程式碼說明；

- 類別 Student 中含有名為 fullname 的 **公開** 成員，即此成員可以直接存取
- constructor 則為此類別的建構子，包含 3 個傳入參數，此種寫法為快速的寫法。
- public 指類別中新創出的 **公開** 成員，在此物件被產生時即產生 3 個公開成員，其效果相同下方程式碼；
- 透過 public 產生的成員，typescript 會自動產生相應的資料型態 (視傳入建構子的變數所致)

```javascript
class Student {
    fullName: string;
    
    // 其中 firstName, middleInitial 與 lastName 定義為 string，是因為傳入建構子的變數為字串所致
    firstName: string;
    middleInitial: string;
    lastName: string;
    
    // ...
}
    
var user = new Student("Jane", "M.", "User");

// ...
```



## 使用 Typescript 所創建的 Javascript

開啟一個檔案，輸入下列 html code，並存成 .html 檔案。而使用的方式與一般使用 javascript 函式庫的方式相同。

```html
<!DOCTYPE html>
<html>
    <head><title>TypeScript Greeter</title></head>
    <body>
        <script src="example.js"></script>
    </body>
</html>
```










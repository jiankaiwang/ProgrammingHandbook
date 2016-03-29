# D3.js

D3 (Data-Driven Documents) 是一套 Javascript 函式庫能夠依照資料本身來修飾要用來呈現的物件。D3.js 基礎是建立在資料與物件的結合，示意圖如下；

![](d3_concept.png)

顏色代表不同公司，數值代表該公司的經濟成長率，在套用資料模型為園圈之下，則透過 d3 將資料內容傳入資料模型，可以得出右側的呈現結果。<br>
**因此 D3 允許將隨意的資料與文件中的物件模型  (DOM, Document Object Model) 進行繫結，即資料驅使化的物件變形。**舉例而言，透過 D3 可以將一串列中的資料轉型成 html table。<br>
底下介紹數種 D3.js 的特性，包含 
1. selection, 
2. dynamic properties, 
3. enter and exit,
4. transformation, not representation,
5. transition

###Selection
---
D3 透過宣告式語法，改良原本透過 W3C DOM API 操作 HTML 文件中物件的方法，可以透過 (1) 組合式，或是 (2) 階層式 等方式來操作 HTML 文件中的物件 (或稱為 node)。

* 直接透過 W3C DOM API 方式來操作 HTML 文件中的物件方法，如下例將 HTML 文件所有 tag 為 p 的物件中的文字顏色改為藍色。

```Javascript
var paragraphs = document.getElementsByTagName("p");
for (var i = 0; i < paragraphs.length; i++) {
  var paragraph = paragraphs.item(i);
  paragraph.style.setProperty("color", "blue", null);
}
```

* 改用 D3 方式來完成將 HTML 文件所有 tag 為 p 的物件中文字顏色改為藍色，如下；

```Javascript
d3.selectAll("p").style("color", "blue");
```

此作法與透過 jQuery 取得全部 &lt;p&gt; 物件後，再進行顏色設置的結果相同，如下；

```Javascript
for(var i = 0 ; i < $("p").length ; i++) { 
  $($("p")[i]).css({ "color": "blue" }); 
}
```

在 D3 中，選取 html 文件中的物件 (node 或是 elements) 可以透過很多種方式來達成，如 containment, attribute values, class 或是 ID 等。

###Dynamic Properties
---












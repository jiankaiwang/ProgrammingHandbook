# CKEditor

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

###開始使用
---
* 首先至官網 [CKEditor Official Download Website](http://ckeditor.com/download) 下載需要的版本，開原版本分成 Basic Package, Standard Package 與 Full Package；一般而言，常用的網頁編輯採用 Standard Package 即可，而若是需要如數學公式撰寫需求，才需要使用 Full Package。

| 註解 |
| -- |
| 底下範例以 Full Package 為例。而使用的版本為 4.5.8。 |

* 解壓縮資料夾，並將整個資料夾 (資料夾名稱 ckeditor) 複製到開發 html 專案的資料夾下。

* 在開發的 html 文件中引用 ckeditor javascript package，如下；

```Html
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
```

| 註解 |
| -- |
| 要注意需先引用 jquery library。 |

* 引用 .js package 後，於 html 文件中定義要使用 ckeditor 的物件，一般而言是以 textarea 為主，如下；

```Html
<textarea name="editorZone" id="editorZone" rows="20" cols="80">
	(內容文字)
</textarea>
```

並配合下列 javascript code 來告訴 ckeditor 要控制的物件。

```Html
<script type="text/javascript">
	CKEDITOR.replace( 'editorZone' );
</script>
```

其中 textarea 中 id 名稱定義主要被 jquery 使用，而相較於 name ，則是可以搭配 form submit 使用來，而 row 與 column 分別定義 textarea 的編輯區域有多少列與多少欄。
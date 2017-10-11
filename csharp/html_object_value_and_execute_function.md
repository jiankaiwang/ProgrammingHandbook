# 取得 HTML 物件內容與執行函式方法

<script type="text/javascript" src="../js/general.js"></script>

常見的伺服器程式開發語言如 ASPX, PHP, JSP, Python (搭配 Jinja) 等，與 HTML, CSS, Javascript 等瀏覽器端的框架共同組成開發網站。為了最佳化網頁視覺效果，CSS 與 Javascript 共同開發瀏覽器端呈現內容。每種伺服器網頁開發語言有不同取得 html 物件値的方式，底下說明數種伺服器端網頁語言的取得方法與執行方法。

###ASPX 與 CSharp
---

舉登入畫面為例，於前端頁面中，針對要取得的 html 物件，於其 html 屬性中加入 「runat="server"」;一般而言，若要取得繁複計算或取値，並不會全交由前端的 Javascript 來處理，因此會在觸動某個按鈕時，開始 Server 端執行，因此可以在要觸動的按鈕中，其 html 屬性中加入 「onserverclick="validAcc"」，而 validAcc 便是可以定義在伺服器端的程式碼，以 ASPX 為例，便是 CSharp 程式碼中定義，如下登入頁面的範例；

```html
<hgroup>
    <h1>測試登入頁</h1>
    <h3>請輸入帳號與密碼</h3>
    <h3 id="showLoginText" runat="server"></h3>
</hgroup>
<form id="form1" runat="server">
    <div class="group">
        <input id="account" runat="server" type="text" />
        <label>帳號</label>
    </div>
    <div class="group">
        <input id="password" runat="server" type="password" />
        <label>密碼</label>
    </div>
    <button id="button1" type="button" class="button buttonBlue" runat="server" onserverclick="validAcc">登入
    </button>
</form>
```

而在伺服器端的設計如下，可以直接透過 html object id 來取得此物件的內容(使用者輸入等)，如 account.Value 與 password.Value 等；也可以透過 InnerText 來將値填入 html object 中，如 showLoginText.InnerText；

```C#
// 伺服器端程式執行碼
protected void validAcc(object sender, EventArgs e)
{
    // 驗證帳號、密碼是否正確
    if (checkAccValid(account.Value, password.Value))
    {
        // 透過 SESSION 儲存資訊
        Session["user"] = true;
        Session["acc"] = account.Value;
        showLoginText.InnerText = "已驗證!";
        // 轉導入登入後的首頁
        Response.Write("<meta http-equiv='refresh' content='0;url=start.aspx' />");
    }
    else {
        // 將 SESSION 清除
        Session["user"] = null;
        Session["acc"] = null;
        // 顯示登入失敗的提示
        showLoginText.InnerText = "請確認帳號密碼!";
        // 重新導回登入畫面
        Response.Write("<meta http-equiv='refresh' content='3;url=login.aspx' />");
    }
}
```

透過上述方法便是 ASPX 取得 html object 値並執行函式的方法。






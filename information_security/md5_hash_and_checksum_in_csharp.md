# MD5 hash and checksum in C#

<script type="text/javascript" src="../js/general.js"></script>

###Compute MD5 Hash code
---

* 透過 byte array 頗析 UTF8 string，然後透過 md5 物件將之計算產生 hash code 後，在將此 hash code 轉成 string。

```csharp
// generate a MD5 object
MD5 md5HashObj = MD5.Create();

// compute a hash code from a input string (getInputStr)
byte[] data = md5HashObj.ComputeHash(Encoding.UTF8.GetBytes(getInputStr));

// convert hash code into a string
/ Create a new Stringbuilder to collect the bytes and also create a string
StringBuilder sBuilder = new StringBuilder();

// loop through each byte of the hashed byte data and format each one as a hexadecimal string.
for (int i = 0; i < data.Length; i++) {
    sBuilder.Append(data[i].ToString("x2"));
}

// string in hexadecimal string
String md5Str = sBuilder.ToString();
```
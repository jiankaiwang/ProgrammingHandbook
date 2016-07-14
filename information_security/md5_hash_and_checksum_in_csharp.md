# MD5 hash and checksum in C#

<script type="text/javascript" src="../js/general.js"></script>

* API 及範例 : [https://github.com/jiankaiwang/seed/blob/master/csharp/MD5HashChecksum.cs](https://github.com/jiankaiwang/seed/blob/master/csharp/MD5HashChecksum.cs)

###Compute MD5 Hash code
---

* 透過 byte array 頗析 UTF8 string，然後透過 md5 物件將之計算產生 hash code 後，在將此 hash code 轉成 string。

```csharp
public String getMD5HashCode(String getInputStr) {
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
  return sBuilder.ToString();
}
```

###Checksum : verify two hash code strings
---

* 兩筆資料可以先透過 MD5 進行雜湊計算及轉換成字串後，透過比較兩個字串來檢查是否相同。

```Csharp
public bool VerifyMd5Hash() {
    String tmpStrMd5 = getMD5HashCode(templateStr);
    String cmpStrMd5 = getMD5HashCode(compareStr);

    // Create a StringComparer as an compare the hashes.
    StringComparer comparer = StringComparer.OrdinalIgnoreCase;

    if (0 == comparer.Compare(tmpStrMd5, cmpStrMd5)) {
        return true;
    }
    else {
        return false;
    }
}
```



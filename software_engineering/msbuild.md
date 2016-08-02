# MsBuild : 開發 Windows 軟體的建置工具

<script type="text/javascript" src="../js/general.js"></script>

### 基本 MsBuild 框架
---

* 由 XML 格式定義一個專案中有哪些要進行建置的 Target，並可以依照參數來執行建置。

* 基本格式如下 (可以直接複製)
  1. 專案預設執行目標為 build
  2. 於 build 工作中顯示出 Message 內容

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	<Target Name="Build">
		<Message Text="Hello Msbuild!" />
	</Target>
</Project>
```

* 建議透過 Visual Studio 2015 中 Visual Studio Tools 的 「適用於 VS2015 的 MSBuild 命令提示字元」工具進行建置。

```bash
# 指令
# project.xml : 要進行建置的專案定義檔
C:\>MsBuild <project.xml>

# 範例如下
C:\Users\JianKaiWang\Desktop>MsBuild example.xml
```


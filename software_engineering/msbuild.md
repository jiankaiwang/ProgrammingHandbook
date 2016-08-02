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
C:\Program Files (x86)\Microsoft Visual Studio 14.0>cd C:\Users\JianKaiWang\Desktop\
C:\Users\JianKaiWang\Desktop>MsBuild example.xml
Microsoft (R) Build Engine version 14.0.24723.2
Copyright (C) Microsoft Corporation. 著作權所有，並保留一切權利。

已經開始建置於 2016/8/2 上午 10:40:08。
節點 1 (預設目標) 上的專案 "C:\Users\JianKaiWang\Desktop\example.xml"。
Build:
  Hello Msbuild!
專案 "C:\Users\JianKaiWang\Desktop\example.xml" (預設目標) 建置完成。


建置成功。
    0 個警告
    0 個錯誤

經過時間 00:00:00.11
```

### 依序建置多個任務
---

* 建置定義檔案如下 :
  1. CallTarget 定義要建置的目標
  2. Target 定義建置的內容

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	<Target Name="Build">		
		<CallTarget Targets="Step 1"/>
		<CallTarget Targets="Step 2"/>
		<CallTarget Targets="Step 3"/>		
	</Target>
	
	<Target Name="Step 1">	
		<Message Text="Step 1" />
	</Target>
	
	<Target Name="Step 2">
		<Message Text="Step 2" />
	</Target>
	
	<Target Name="Step 3">
		<Message Text="Step 3" />
	</Target>
</Project>
```

* 建置結果如下

```bash
C:\Users\JianKaiWang\Desktop>MsBuild example.xml
Microsoft (R) Build Engine version 14.0.24723.2
Copyright (C) Microsoft Corporation. 著作權所有，並保留一切權利。

已經開始建置於 2016/8/2 上午 10:56:58。
節點 1 (預設目標) 上的專案 "C:\Users\JianKaiWang\Desktop\example.xml"。
Step 1:
  Step 1
Step 2:
  Step 2
Step 3:
  Step 3
專案 "C:\Users\JianKaiWang\Desktop\example.xml" (預設目標) 建置完成。


建置成功。
    0 個警告
    0 個錯誤

經過時間 00:00:00.04
```








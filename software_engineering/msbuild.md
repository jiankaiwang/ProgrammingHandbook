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

### ItemGroup 與 Item 的使用
---

* MsBuild 中透過 Item 指定專案建置中所包含的項目，ItemGroup 為 Item 的集合

* ItemGroup 中可以定義 Item 名稱與內容如下範例

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	<ItemGroup>		
		<ProjectFiles Include="C:\Users\JianKaiWang\Desktop\demo\demo\demo\**\*.cs" />		
	</ItemGroup>
	
	<Target Name="Build">
		<Message Text="@(ProjectFiles)" />
	</Target>
</Project>
```

* 建置結果如下 :

```bash
C:\Users\JianKaiWang\Desktop>MsBuild example.xml
Microsoft (R) Build Engine version 14.0.24723.2
Copyright (C) Microsoft Corporation. 著作權所有，並保留一切權利。

已經開始建置於 2016/8/2 上午 11:03:14。
節點 1 (預設目標) 上的專案 "C:\Users\JianKaiWang\Desktop\example.xml"。
Build:
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\obj\Debug\TemporaryGeneratedFile_
  036C0B5B-1481-4323-8D20-8F5ADCB23D92.cs;C:\Users\JianKaiWang\Desktop\demo\dem
  o\demo\obj\Debug\TemporaryGeneratedFile_5937a670-0e60-4077-877b-f7221da3dda1.
  cs;C:\Users\JianKaiWang\Desktop\demo\demo\demo\obj\Debug\TemporaryGeneratedFi
  le_E7A71F73-0F8D-4B9B-B56E-8E70B10BC5D3.cs;C:\Users\JianKaiWang\Desktop\demo\
  demo\demo\Program.cs;C:\Users\JianKaiWang\Desktop\demo\demo\demo\Properties\A
  ssemblyInfo.cs
專案 "C:\Users\JianKaiWang\Desktop\example.xml" (預設目標) 建置完成。


建置成功。
    0 個警告
    0 個錯誤

經過時間 00:00:00.04
```














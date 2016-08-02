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

* ItemGroup 中可以定義 Item 名稱與內容，如下範例：
  1. ProjectFiles 為 item 的自定義名稱，而 item 包含要建置的內容，此處以建置 csharp 檔案為例。
  2. 建置時透過 @(ProjectFiles) 來輸出內容。

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

* 客製化顯示結果：
  1. 因 item 輸出內容以分號作為區隔，可以透過 @(ItemName,'Seperator') 指定分隔符號
  2. 例如透過 @(ItemName->'Files:%(FullPath)','%0a') 來換行顯示，%0a 表示換行符號

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	<ItemGroup>		
		<ProjectFiles Include="C:\Users\JianKaiWang\Desktop\demo\demo\demo\**\*.cs" />		
	</ItemGroup>
	
	<Target Name="Build">
		<Message Text="@(ProjectFiles->'Files:%(FullPath)','%0a')" />
	</Target>
</Project>
```

* 客製化建置結果如下 :

```bash
C:\Users\JianKaiWang\Desktop>MsBuild example.xml
Microsoft (R) Build Engine version 14.0.24723.2
Copyright (C) Microsoft Corporation. 著作權所有，並保留一切權利。

已經開始建置於 2016/8/2 上午 11:08:43。
節點 1 (預設目標) 上的專案 "C:\Users\JianKaiWang\Desktop\example.xml"。
Build:
  Files:C:\Users\JianKaiWang\Desktop\demo\demo\demo\obj\Debug\TemporaryGenerate
  dFile_036C0B5B-1481-4323-8D20-8F5ADCB23D92.cs
  Files:C:\Users\JianKaiWang\Desktop\demo\demo\demo\obj\Debug\TemporaryGenerate
  dFile_5937a670-0e60-4077-877b-f7221da3dda1.cs
  Files:C:\Users\JianKaiWang\Desktop\demo\demo\demo\obj\Debug\TemporaryGenerate
  dFile_E7A71F73-0F8D-4B9B-B56E-8E70B10BC5D3.cs
  Files:C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs
  Files:C:\Users\JianKaiWang\Desktop\demo\demo\demo\Properties\AssemblyInfo.cs
專案 "C:\Users\JianKaiWang\Desktop\example.xml" (預設目標) 建置完成。


建置成功。
    0 個警告
    0 個錯誤

經過時間 00:00:00.05
```

### PropertyGroup 與 Property 的使用
---

* Property 為使用者定義的屬性與値，一般而言常用來放置可變更之變數，如輸出路徑 (包含如 SourceMonitor 職行路徑) 等，此可以透過 $(PropertyName) 來呼叫結果，執行範例如下 :

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">	
	<PropertyGroup>
		<SimianPath>C:\Program Files (x86)\simian\bin\simian-2.4.0.exe</SimianPath>		
	</PropertyGroup>
	
	<Target Name="Build">
		<Message Text="$(SimianPath)" />
	</Target>
</Project>
```

* 建置結果如下 :

```bash
C:\Users\JianKaiWang\Desktop>MsBuild example.xml
Microsoft (R) Build Engine version 14.0.24723.2
Copyright (C) Microsoft Corporation. 著作權所有，並保留一切權利。

已經開始建置於 2016/8/2 上午 11:15:47。
節點 1 (預設目標) 上的專案 "C:\Users\JianKaiWang\Desktop\example.xml"。
Build:
  "C:\Program Files (x86)\simian\bin\simian-2.4.0.exe"
專案 "C:\Users\JianKaiWang\Desktop\example.xml" (預設目標) 建置完成。


建置成功。
    0 個警告
    0 個錯誤

經過時間 00:00:00.03
```

### 執行專案建置工作 (Task)
---

* Target 中的每一項執行，都是一個 task (如前述的 message)，除 MsBuild 本身支援的 task 外，亦可以使用第三方軟體的 Task，如下範例的 StyleCop，並配合上述所提的 ItemGroup 與 PropertyGroup 使用進行專案建置：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Defaulttargets="StyleCop" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	<UsingTask AssemblyFile="C:\Program Files (x86)\StyleCop 4.7\StyleCop.dll" TaskName="StyleCopTask" />

	<ItemGroup>		
		<StyleCopFiles Include="C:\Users\JianKaiWang\Desktop\demo\demo\demo\**\*.cs" Exclude="C:\Users\JianKaiWang\Desktop\demo\demo\demo\**\*Test.cs" />		
	</ItemGroup>
	
	<PropertyGroup>
		<ProjectFullPath>C:\Users\JianKaiWang\Desktop\demo\demo</ProjectFullPath>		
	</PropertyGroup>
	
	<Target Name="StyleCop">
		<StyleCopTask
			ProjectFullPath="$(ProjectFullPath)"
			SourceFiles="@(StyleCopFiles)"
			ForceFullAnalysis="true"
			TreatErrorsAsWarnings="true"
			OutputFile="$(ProjectFullPath)\StyleCopReport.xml"
			CacheResults="true" />    
	</Target>
</Project>
```

| 註解 |
| -- |
| 請注意呼叫 ItemGroup 與 PropertyGroup 的變數方式不同，為 @ 與 $。 |

* 建置結果如下

```bash
C:\Users\JianKaiWang\Desktop>MsBuild example.xml
Microsoft (R) Build Engine version 14.0.24723.2
Copyright (C) Microsoft Corporation. 著作權所有，並保留一切權利。

已經開始建置於 2016/8/2 上午 11:31:54。
節點 1 (預設目標) 上的專案 "C:\Users\JianKaiWang\Desktop\example.xml"。
StyleCop:
  Skipping: demo - \demo\obj\Debug\TemporaryGeneratedFile_036C0B5B-1481-4323-8D
  20-8F5ADCB23D92.cs
  Skipping: demo - \demo\obj\Debug\TemporaryGeneratedFile_5937a670-0e60-4077-87
  7b-f7221da3dda1.cs
  Skipping: demo - \demo\obj\Debug\TemporaryGeneratedFile_E7A71F73-0F8D-4B9B-B5
  6E-8E70B10BC5D3.cs
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(9,1): warning : SA1600 :
 CSharp.Documentation : The class must have a documentation header. [C:\Users\J
ianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(11,1): warning : SA1600
: CSharp.Documentation : The method must have a documentation header. [C:\Users
\JianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(1,1): warning : SA1633 :
 CSharp.Documentation : The file has no header, the header Xml is invalid, or t
he header is not located at the top of the file. [C:\Users\JianKaiWang\Desktop\
example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(9,1): warning : SA1400 :
 CSharp.Maintainability : The class must have an access modifier. [C:\Users\Jia
nKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(11,1): warning : SA1400
: CSharp.Maintainability : The method must have an access modifier. [C:\Users\J
ianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(7,1): warning : SA1300 :
 CSharp.Naming : namespace names begin with an upper-case letter: demo. [C:\Use
rs\JianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(1,1): warning : SA1200 :
 CSharp.Ordering : All using directives must be placed inside of the namespace.
 [C:\Users\JianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(2,1): warning : SA1200 :
 CSharp.Ordering : All using directives must be placed inside of the namespace.
 [C:\Users\JianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(3,1): warning : SA1200 :
 CSharp.Ordering : All using directives must be placed inside of the namespace.
 [C:\Users\JianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(4,1): warning : SA1200 :
 CSharp.Ordering : All using directives must be placed inside of the namespace.
 [C:\Users\JianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(5,1): warning : SA1200 :
 CSharp.Ordering : All using directives must be placed inside of the namespace.
 [C:\Users\JianKaiWang\Desktop\example.xml]
C:\Users\JianKaiWang\Desktop\demo\demo\demo\Properties\AssemblyInfo.cs(1,1): wa
rning : SA1633 : CSharp.Documentation : The file has no header, the header Xml
is invalid, or the header is not located at the top of the file. [C:\Users\Jian
KaiWang\Desktop\example.xml]
  12 violations encountered.
專案 "C:\Users\JianKaiWang\Desktop\example.xml" (預設目標) 建置完成。


建置成功。

"C:\Users\JianKaiWang\Desktop\example.xml" (預設目標) (1) ->
(StyleCop 目標) ->
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(9,1): warning : SA1600
 : CSharp.Documentation : The class must have a documentation header. [C:\Users
\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(11,1): warning : SA160
0 : CSharp.Documentation : The method must have a documentation header. [C:\Use
rs\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(1,1): warning : SA1633
 : CSharp.Documentation : The file has no header, the header Xml is invalid, or
 the header is not located at the top of the file. [C:\Users\JianKaiWang\Deskto
p\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(9,1): warning : SA1400
 : CSharp.Maintainability : The class must have an access modifier. [C:\Users\J
ianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(11,1): warning : SA140
0 : CSharp.Maintainability : The method must have an access modifier. [C:\Users
\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(7,1): warning : SA1300
 : CSharp.Naming : namespace names begin with an upper-case letter: demo. [C:\U
sers\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(1,1): warning : SA1200
 : CSharp.Ordering : All using directives must be placed inside of the namespac
e. [C:\Users\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(2,1): warning : SA1200
 : CSharp.Ordering : All using directives must be placed inside of the namespac
e. [C:\Users\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(3,1): warning : SA1200
 : CSharp.Ordering : All using directives must be placed inside of the namespac
e. [C:\Users\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(4,1): warning : SA1200
 : CSharp.Ordering : All using directives must be placed inside of the namespac
e. [C:\Users\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Program.cs(5,1): warning : SA1200
 : CSharp.Ordering : All using directives must be placed inside of the namespac
e. [C:\Users\JianKaiWang\Desktop\example.xml]
  C:\Users\JianKaiWang\Desktop\demo\demo\demo\Properties\AssemblyInfo.cs(1,1):
warning : SA1633 : CSharp.Documentation : The file has no header, the header Xm
l is invalid, or the header is not located at the top of the file. [C:\Users\Ji
anKaiWang\Desktop\example.xml]

    12 個警告
    0 個錯誤

經過時間 00:00:00.43
```





# WebAssembly Quick Start



透過 WebAssembly (**WASM**) 技術，將 C/C++ 技術導入前端 javascript 中，優化純粹使用 javascript 的較低執行效率。概念為將 javascript 中與關鍵效能有關的部分，以 C/C++ 撰寫後，並透過 WebAssembly 專屬編輯器 (如 Emscripten, LLVM to JS compiler, http://kripken.github.io/emscripten-site/index.html) 進行編譯後，可以透過 FetchAPI 或 import js module (瀏覽器尚未完全支援) 導入 javascript application。反之亦然，可以在 C/C++ 中呼叫 javascript 函式來互相搭配。Assembly 的另一項優點，自由控制記憶體的存取與釋放等，在 WebAssembly 一樣有支援。安全性在 webassembly 中一樣受到重視，WebAssembly 運行在沙盒之中，進入 Web 時會強制使用瀏覽器的 Same-Origin 等規範，此外針對記憶體存取亦是 memory-safe。

WebAssembly 由 W3C Community Group 開發，成員為常見的瀏覽器開發商。目前版本為 MVP(Minimum Viable Product)，提供 **asm.js** 的多數功能，以 C/C++ 實作編譯為主。



## 準備 Emscripten 環境



- 透過 [kripken/emscripten](https://github.com/kripken/emscripten) 進行編譯 C/C++ 程式碼
  - 官方網站: http://kripken.github.io/emscripten-site/
- 下載 SDK (portable 為例): http://kripken.github.io/emscripten-site/docs/getting_started/downloads.html
- 安裝 SDK (以 Windows 為例，可以參考 **README.md** 文件中的 **Installation Instructions**)

```shell
cd C:\programs\emsdk-portable-64bit
emsdk update
emsdk install latest
emsdk activate latest
emsdk activate --global latest  # persist environment variables to all command prompts
```



## Emscripten 指令



* Running Emscripten

```cpp
// the example code in index.cpp
#include <stdio.h>

int main() {
  printf("hello, world!\n");
  return 0;
}
```

```shell
# verifying and version
# emcc for c and em++ for c++
emcc -v
em++ -v

# compile C++ file to javascript
# it would generate a.out.js file
em++ index.cpp

# run the javascript
node a.out.js
```



* Generating HTML

```shell
# generate html for testing embedded javascript code
# it would generate two files, index.html and index.js
# put the above two files in the wwwroot file
# then surf the localhost/index.html
em++ index.cpp -o index.html

# generate WASM file
# -s WASM=1 enforce using WASM, not asm.js (def)
# without -o flag, it would generate a.out.wasm and a.out.js
em++ index.cpp -s WASM=1 [-o index.html]
```



## WASM 產生



* 可以透過 **Emscripten** 工具或是 **[WasmFiddle](https://wasdk.github.io/WasmFiddle)** 或 **[WasmExplorer](http://mbebenita.github.io/WasmExplorer/)** 等線上工具產生 WASM 資料，一般而言 WASM 由底下二項組成: 
  * 二進制: `.wasm` 檔案(主要引用檔案)
  * 文字檔案:`.wast` 檔案可以由 wasm 檔案轉換而成



* C/C++ 範例碼

```c++
int add(int num1, int num2) {
    return(num1 + num2);
}
```



* `.wasm` 二進制檔案轉成十六進制內容 (以 WasmFiddle 為例)

```text
0061 736d 0100 0000 0187 8080 8000 0160
027f 7f01 7f03 8280 8080 0001 0004 8480
8080 0001 7000 0005 8380 8080 0001 0001
0681 8080 8000 0007 9080 8080 0002 066d
656d 6f72 7902 0003 6164 6400 000a 8d80
8080 0001 8780 8080 0000 2001 2000 6a0b
```



* `.wast` 文字檔案: 以組合語言方式呈現 (以 WasmFiddle 為例)

```assembly
(module
 (table 0 anyfunc)
 (memory $0 1)
 (export "memory" (memory $0))
 (export "add" (func $add))
 (func $add (; 0 ;) (param $0 i32) (param $1 i32) (result i32)
  (i32.add
   (get_local $1)
   (get_local $0)
  )
 )
)
```



## 使用 WebAssembly 方法



* 直接透過 script tag 匯入 WASM 資源

```html
<!-- import wasm like a script resource -->
<script src="program.wasm" type="module"></script>
```



* 透過 Fetch API 匯入 WASM 資源

透過 Fetch API 匯入 WASM 資源 (類似 wasm-loader)，包含 compile, instantiate and exports。

```javascript
function fetchAndInstantiateWasm(url, imports) {
    return fetch(url)    // url could be your .wasm file
    .then(res => {
    if (res.ok)
        return res.arrayBuffer();
    throw new Error(`Unable to fetch Web Assembly file ${url}.`);
    })
    .then(bytes => WebAssembly.compile(bytes))
    .then(module => WebAssembly.instantiate(module, imports || {}))
    .then(instance => instance.exports);
}
```

Javascript 中使用 WebAssembly 資源 (以 WasmFiddle 為例)

```javascript
fetchAndInstantiateWasm('program.wasm',{})
  .then(m => {
  	console.log(m.add(5,10));
});
```



* 於 WebAssembly 中使用 Javascript 函式


C++ 範例檔案

```c++
void consoleLog (int num);
int multiply(int num1, int num2) {
    int result = num1 * num2;
    consoleLog(result);
    return result;
}
```

先將之透過編譯器轉成名為 **mutiply.wasm** 檔案後，於 javascript 中進行實作

```javascript
fetchAndInstantiateWasm('./mutiply.wasm', {
    env: {
        consoleLog: num => console.log(num)
    }
})
.then(m => {
    m.multiply(5, 10)
});
```






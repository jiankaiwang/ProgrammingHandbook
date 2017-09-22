# GO Language

<script type="text/javascript" src="../js/general.js"></script>

### Background
---

* Developed By **Google**
* Designer : 
    * Robert Griesemer, 
    * Rob Pike, 
    * Ken Thompson
* Released at **2009**
* Based on **Inferno** (Distributed System)
* **BSD** License
* Environment : Windows / Linux / Mac OS
* Invoked Languages : **C** / Oberon / Limbo


### Programming Language
---

* static type / strong data type
* Compiled : gc, gccgo
* Compared C / C++
    * Unsupported : exception, inheritance, template, assertion, virtual function
    * Supported : slice, parallel, interface, garbage collection, hash
* Style : 
    * No need comma
    * {} can’t be replaced on the next line
    * No () for the branch (IF) or loop
* Parallelized : Goroutine
    * Non-blocked by go syntax


### Necessary Resources
---

* Effective GO : [https://golang.org/doc/effective_go.html](https://golang.org/doc/effective_go.html)
* 《Effective Go》中英双语版 : [https://www.gitbook.com/book/bingohuang/effective-go-zh-en/details](https://www.gitbook.com/book/bingohuang/effective-go-zh-en/details)

### Environment Variable Setting
---

* Windows
    * Set **GOPATH** in environment setting with the value pointing to the specific directory, e.g. **C:\work**.

### Necessary tools
---    

* GO Core : [https://golang.org/](https://golang.org/)

* Suggested Tool : [Visual Studio Code](https://code.visualstudio.com/)
    * install Necessary Debug tool on VSCode : ```go get github.com/derekparker/delve/cmd/dlv```
    
### Action On Command
---

```batch
# go version
> go version

# build the source code
> go build filePath

# download and install the package
> go get packageURI

# format the source code
> go fmt filePath
```
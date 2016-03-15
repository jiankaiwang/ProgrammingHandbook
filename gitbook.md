# GitBook

### Gitbook Codeblock highlighting
---
#### Install
1. Create a 「book.json」 in the directory (or In Editor, 「Book」> 「Edit Configuration」)
2. Add the following content in it
```Javascript
{
    "plugins" : [ "include-highlight" ],
}
```

#### Configuration
You can map file extensions that don't match syntax used in contents by adding a mapping in your book.json plugin configuration section。
```Javascript
"pluginsConfig": {
    "include-highlight": {
        "extensionToLanguage": {
          "R": "r",
          "Javascript": "js",
          "C++": "cpp",
          "Java": "java",
          "Python": "py",
          "SQL": "sql"
        }
    }
}
```

#### Usage
1. Click the Code button 。
2. It shows \`\`\` (here is the code) \`\`\` 
3. Add the 「Language Name」 just after the first \`\`\`
4. for example,<br><br>
\`\`\`Python<br>
(python code here)<br>
\`\`\`<br><br>

#### [CSS Styleable reference](http://highlightjs.readthedocs.org/en/latest/css-classes-reference.html)
##### Just remember the 「Language Name」 above must be one of the 「Language names and aliases」


 ### GitBook Cover
 ---
 * Simply add a image named 「cover.jpg」 (notice: only this file name with .jpg extension is accepted) in the file directory.
 * Use plugin named autocover:
   * append "autocover" to the "plugins" list in the "book.json" file
   * the configuration would be customized as the following setting
```Javascript

```


### Programming Languages Supported
---
* Jinja2 in Ckan: the block tag, {, would cause gitbook parsing errors.



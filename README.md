# QuickNote
A fast, simple, light-weight markdown editor under 200kb.

## About
Notes are awesome pieces of information, essential to our daily lives. It is important that taking notes is fast and easy. Simple .txts are great for this; however, sometimes it's useful to have some more formatting and a prettier interface. Markdown is a great solution. This app is really meant to be simple markdown editor; it has objectively less features than other programs on purpose. It is supposed to be light-weight, and really fast. It weighs in under 200 kilobytes. There's no Electron here, no heavy cross-platform frameworks, it's just a native Mac app. Some apps require big upfront payments, and some even a monthly subscription – that's not worth it for just simple notes. That's why this app is completely free – as in beer, and as in speech. 

## Markdown in QuickNote
Markdown is used a bit differently in QuickNote – not all features are implemented, and not all features will be implemented. If you write something in QuickNote, it will probably be supported by other apps. However, many documents written in other apps might not work here.

**Markdown features implemented in QuickNote:**
* Headings (starting with `#`)
* Bold (delineated by `*`)
* Italic (delineated by `**`)
* Bold-italic (delineated by `***`)
* Strikethrough (delineated by `~~`)
* Lists (like this one)
* Code blocks (*without syntax highlighting*)
* Inline code
* Web Links (non-relative links only)
* Links pointing to files (prefaced with file://)
* Thematic breaks (indicated with `---`)

**Markdown features not currently implemented:**
* Tables
* Blockquotes
* Footnotes
* Task lists

**Markdown features that will never be implemented:**
* Images
* Code syntax highlighting
* Relative links
* Heading IDs

## Installing
> *Note*: Installing a compiled binary directly is not recommended, since this app is not code-signed. Proceed at your own risk.
To install the app binary directly, download the latest release from [the Releases page](https://github.com/daemonleaf/QuickNote/releases), unzip the file, and move the app to the Applications directory, or wherever you see fit. Then, run the following commands in a terminal window:
```sh
$ xattr -d com.apple.quarantine /Applications/QuickNote.app # remove from quarantine
$ codesign -s - /Applications/QuickNote.app # sign to run locally
```

## Building and Installing (recommended)
In a new terminal window, clone this repository using git `git clone https://github.com/daemonleaf/QuickNote.git` or the Github CLI `gh repo clone daemonleaf/QuickNote`. Open the the QuickNote.xcodeproj file with Xcode, and archive the project, by running selecting Product > Archive. Then, in the archive pane, which can be opened from Window > Organizer, select the QuickNote project, and click on Distribute app. Choose `Copy app` and save it in a temporary directory. Move the app from the temporary directory to your applications folder.

## License
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>

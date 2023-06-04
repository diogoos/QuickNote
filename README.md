# QuickNote
QuickNote is a Swift-based application that provides a fast, simple, and lightweight markdown editor. It is designed to make it easy for users to create and edit markdown files on the go. With QuickNote, you can focus on writing and formatting your content without any distractions.

![QuickNote screenshot](https://raw.githubusercontent.com/diogoos/QuickNote/main/.github/demo.png)

## Features
* Markdown Editing: QuickNote allows you to write and edit markdown files using a clean and intuitive interface.
* Live Preview: The application provides a live preview of the rendered markdown, allowing you to see how your content will appear in real-time.
* Fast: The application is built using Swift, which allows it to run lightning-fast on MacOS

## Getting started
1. Clone the repository
```bash
git clone https://github.com/diogoos/QuickNote.git
```
2. Open the project in Xcode
3. Build and run!

## Dependencies
QuickNote relies on the following dependencies, which are managed using Swift Package Manager:

This project uses my own framework, [MarkParse Kit](https://github.com/daemonleaf/MarkParse), for markdown parsing.
MarkParse kit is a light, expandable, native framework to parse markdown. It was custom built for this app!
Check out more details in its project page!

**Markdown features implemented in QuickNote:**
* Headings and subheadings (starting with `#`)
* Italic (delineated by `*`)
* Bold (delineated by `**`)
* Bold-italic (delineated by `***`)
* Strikethrough (delineated by `~~`)
* Lists (like this one)
* Code blocks
* Inline code
* Web Links (non-relative links only)
* Links pointing to files (prefaced with file://)
* Thematic breaks (indicated with `---`)

**Markdown features not currently implemented:**
* Tables
* Blockquotes
* Footnotes
* Task lists


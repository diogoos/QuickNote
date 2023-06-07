//
//  SplitViewController.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa
import MarkParse

class SplitViewController: NSViewController, Storyboarded {
    @IBOutlet var editorTextView: NSTextView!
    @IBOutlet var viewerTextView: NSTextView!
    var viewerText: String = ""

    override var representedObject: Any? {
        didSet {
            loadDocument()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewerTextView.isEditable = false
        viewerTextView.textColor = .yellow
        viewerTextView.font = .systemFont(ofSize: 17)
        viewerTextView.textContainerInset = NSSize(width: 10.0, height: 10.0)

        editorTextView.font = .systemFont(ofSize: 17)
        editorTextView.delegate = self
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        loadDocument()
    }

    func loadDocument() {
        guard let loadedString = representedObject as? QuickNote else { return }
        editorTextView.string = loadedString.text
    }
}

extension SplitViewController: NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        // parse markdown only if the text has changed
        if viewerText != editorTextView.string {
            var parsers = MarkdownRenderer.defaultParsers
            parsers.insert(ImageParser(enabled: false), at: 2)

            let renderer = MarkdownRenderer(parsers: parsers)
            viewerTextView.textStorage!.setAttributedString(renderer.attributedString(from: editorTextView.string))
            viewerText = editorTextView.string
        }

        // save
        (representedObject as? QuickNote)?.text = editorTextView.string
    }
}

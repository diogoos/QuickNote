//
//  SplitViewController.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

class SplitViewController: NSViewController, Storyboarded {
    @IBOutlet var editorTextView: NSTextView!
    @IBOutlet var viewerTextView: NSTextView!

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
        viewerTextView.string = editorTextView.string
        (representedObject as? QuickNote)?.text = editorTextView.string
    }
}

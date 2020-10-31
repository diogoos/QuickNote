//
//  ViewerViewController.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa
import MarkParse

class ViewerViewController: NSViewController, Storyboarded {
    @IBOutlet var textView: NSTextView!
    var owner: Int?

    override var representedObject: Any? {
        didSet {
            loadContent()
        }
    }

    override func viewWillAppear() {
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = .yellow
        textView.isEditable = false
        textView.textContainerInset = NSSize(width: 10.0, height: 10.0)

        loadContent()
    }

    func loadContent() {
        guard let note = representedObject as? QuickNote else { return }

        var parsers = MarkdownRenderer.defaultParsers
        parsers.insert(NoImageParser(), at: 2)

        let parser = MarkdownRenderer(parsers: parsers)
        textView.textStorage!.setAttributedString(parser.attributedString(from: note.text))
    }
}

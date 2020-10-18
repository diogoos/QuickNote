//
//  ViewController.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/16/20.
//

import Cocoa

class EditorViewController: NSViewController, Storyboarded {
    @IBOutlet var textView: NSTextView!
    var changeCallback: ((String) -> Void)?

    override var representedObject: Any? {
        didSet {
            populateDocumentContent()
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()

        textView.font = .systemFont(ofSize: 17)
        textView.allowsUndo = true
        textView.delegate = self

        populateDocumentContent()
    }

    override func viewWillDisappear() {
        textViewDidChangeSelection(Notification(name: Notification.Name("ViewWillChange")))
    }

    func populateDocumentContent() {
        guard let content = representedObject as? QuickNote else { return }
        textView.string = content.text
    }
}

extension EditorViewController: NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        (representedObject as? QuickNote)?.text = textView.string
        changeCallback?(textView.string)
    }
}

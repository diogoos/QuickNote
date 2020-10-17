//
//  ViewController.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/16/20.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet var textView: NSTextView!

    override func viewWillAppear() {
        super.viewWillAppear()

        textView.font = .systemFont(ofSize: 17)
        textView.delegate = self

        populateDocumentContent()
    }

    func populateDocumentContent() {
        guard let content = representedObject as? QuickNote else { return }
        textView.string = content.text
    }
}

extension ViewController: NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        (representedObject as? QuickNote)?.text = textView.string
    }
}

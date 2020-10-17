//
//  ViewerViewController.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

class ViewerViewController: NSViewController, Storyboarded {
    @IBOutlet var textView: NSTextView!
    var owner: Int? = nil

    override var representedObject: Any? {
        didSet {
            loadContent()
        }
    }

    override func viewWillAppear() {
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = .yellow
        textView.isEditable = false

        loadContent()
    }

    func loadContent() {
        guard let content = representedObject as? QuickNote else { return }
        textView.string = content.text
    }
}

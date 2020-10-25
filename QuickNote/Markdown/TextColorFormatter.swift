//
//  TextColorFormatter.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

struct TextColorFormatter: MarkdownParser {
    func line(_ line: String) -> NSAttributedString? { nil }
    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString {
        richText.addAttribute(.foregroundColor,
                              value: NSColor.textColor,
                              range: NSRange(location: 0, length: richText.length))
        return richText
    }
}

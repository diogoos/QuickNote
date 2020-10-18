//
//  TextStyleParser.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

struct TextStyleParser: MarkdownParser {
    var matchers: [TextStyleMatcher]
    var basePixel: Int = 16
    let sizeRatio: Double = 0.875

    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString {
        var richText = richText

        for matcher in matchers {
            richText = matcher.match(in: richText)
        }

        return richText
    }

    func line(_ line: String) -> NSAttributedString? { nil }
}

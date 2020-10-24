//
//  Markdown.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Foundation

protocol MarkdownParser {
    func line(_ line: String) -> NSAttributedString?
    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString
}

protocol IncrementalMarkdownParser: MarkdownParser {
    func attributedLine(_ line: NSMutableAttributedString) -> NSMutableAttributedString
}

struct Markdown {
    static let defaultParsers: [MarkdownParser] = [
        HeaderParser(),
        ThematicBreakParser(),
        LinkParser(),
        ListParser(),
        CodeBlockParser(),
        TextStyleParser(matchers: MarkdownTextStyleMatchers.all),
        BodyParser(),
        TextColorFormatter()
    ]
    var parsers: [MarkdownParser]

    func richText(from string: String) -> NSAttributedString {
        var richText = NSMutableAttributedString()
        let lines = string.components(separatedBy: "\n")
        for line in lines {
            let line = line + "\n"
            var parsedLine = NSMutableAttributedString()

            for parser in parsers {
                if let result = parser.line(line) {
                    parsedLine = NSMutableAttributedString(attributedString: result)
                    break
                }
            }

            for parser in parsers {
                if let parser = parser as? IncrementalMarkdownParser {
                    parsedLine = parser.attributedLine(parsedLine)
                }
            }

            richText.append(parsedLine)
        }

        parsers.forEach { richText = $0.whole(richText) }

        return richText as NSAttributedString
    }
}

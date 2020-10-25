//
//  CodeBlockParser.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/18/20.
//

import Cocoa

struct CodeBlockParser: MarkdownParser {
    static let blockRegex = NSRegularExpression(staticPattern: "```(.*?)\n(.*?)```", options: .dotMatchesLineSeparators)

    func line(_ line: String) -> NSAttributedString? { nil }

    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString {
        let matches = Self.blockRegex.matches(in: richText.string,
                                              options: [],
                                              range: NSRange(location: 0, length: richText.string.utf16.count))

        let original = richText.string.copy() as! NSString // swiftlint:disable:this force_cast

        var deviation: Int = 0
        for match in matches {
            // group1: language
            // group2: code

            let matchString = original.substring(with: match.range)
            // let language = original.substring(with: match.range(at: 1))
            let codeString = original.substring(with: match.range(at: 2))

            // make updated range
            let updatedRange = NSRange(location: match.range.location - deviation, length: match.range.length)

            // add attributes
            richText.addAttributes([
                .font: NSFont.monospacedSystemFont(ofSize: 14, weight: .regular),
                .backgroundColor: NSColor.windowBackgroundColor
            ], range: updatedRange)
            richText.mutableString.replaceCharacters(in: updatedRange, with: codeString)

            // add deviation
            deviation += matchString.count - codeString.count
        }

        return richText
    }
}

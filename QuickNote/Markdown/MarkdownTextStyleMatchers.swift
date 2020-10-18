//
//  MarkdownTextStyleMatchers.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/18/20.
//

import Cocoa

struct MarkdownTextStyleMatchers {

    static let boldItalicText = TextStyleMatcher(regexString: "\\*\\*\\*(.*?)\\*\\*\\*",
                                                 regexOptions: .dotMatchesLineSeparators,
                                                 delimiter: "***",
                                                 attributes: [.font: NSFont.boldItalicSystemFont(ofSize: 14)])

    static let boldText = TextStyleMatcher(regexString: "\\*\\*(.*?)\\*\\*",
                                           regexOptions: .dotMatchesLineSeparators,
                                           delimiter: "**",
                                           attributes: [.font: NSFont.boldSystemFont(ofSize: 14)])

    static let italicText = TextStyleMatcher(regexString: "\\*(.*?)\\*",
                                             regexOptions: .dotMatchesLineSeparators,
                                             delimiter: "*",
                                             attributes: [.font: NSFont.italicSystemFont(ofSize: 14)])

    static let strikethroughText = TextStyleMatcher(regexString: "~~(.*?)~~",
//                                                    regexOptions: .dotMatchesLineSeparators,
                                                    delimiter: "~~",
                                                    attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])

    static let underlineText = TextStyleMatcher(regexString: "____(.*?)____",
                                                delimiter: "____",
                                                attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])

    static let inlineCode = TextStyleMatcher(regexString: "`(.*?)`",
                                             delimiter: "`",
                                             attributes: [
                                                .font: NSFont.monospacedSystemFont(ofSize: 14, weight: .regular),
                                                .backgroundColor: NSColor.windowBackgroundColor
                                             ])

    static let all = [
        boldItalicText,
        boldText,
        italicText,
        strikethroughText,
        underlineText,
        inlineCode
    ]
}

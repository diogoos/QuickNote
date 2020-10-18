//
//  LinkParser.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/18/20.
//

import Foundation

struct LinkParser: IncrementalMarkdownParser {
    static let regex = try! NSRegularExpression(pattern: "\\[(.*?)\\]\\((.*?)\\)", options: [])

    func attributedLine(_ line: NSMutableAttributedString) -> NSMutableAttributedString {
        // we need to keep a copy of the original line, to match later
        let original: NSString = (line.string as NSString).copy() as! NSString

        // find the maches in the lines
        let matches = LinkParser.regex.matches(in: line.string,
                                               options: [],
                                               range: NSRange(location: 0, length: line.string.utf16.count))

        var locationCharShift: Int = 0
        for match in matches {
            // if we don't have two groups, something went wrong
            if match.numberOfRanges < 2 { continue }

            let instance = original.substring(with: match.range)
            let title = original.substring(with: match.range(at: 1))
            let link = original.substring(with: match.range(at: 2))

            // every time we replace text, the line shifts
            // record the number of characters to the left
            // that the text shifted, so we can "undo"
            // this the next time the loop is run.
            let updatedRange = NSMakeRange(match.range.location - locationCharShift, match.range.length)
            locationCharShift += instance.count - title.count

            // add link, then remove brackets and url
            line.addAttributes([.link: link], range: updatedRange)
            line.replaceCharacters(in: updatedRange, with: title)
        }
        return line
    }

    func line(_ line: String) -> NSAttributedString? { nil }

    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString { richText }
}

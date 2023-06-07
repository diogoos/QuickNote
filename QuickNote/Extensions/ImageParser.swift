//
//  ImageParser.swift
//  QuickNote
//
//  Created by Diogo Silva on 6/7/23.
//

import Foundation
import AppKit
import MarkParse

public struct ImageParser: MarkdownParser {
    static let regex = NSRegularExpression(staticPattern: "!\\[(.*?)\\]\\((.*?)\\)", options: [])
    var enabled: Bool

    init(enabled: Bool = true) {
        self.enabled = enabled
    }

    public func modify(line: NSMutableAttributedString) -> NSMutableAttributedString? {
        // we need to keep a copy of the original line, to match later
        let original: NSString = line.string.copy() as! NSString // swiftlint:disable:this force_cast

        // find the maches in the lines
        let matches = Self.regex.matches(in: line.string, options: [], range: NSRange(location: 0, length: line.string.utf16.count))

        var locationCharShift: Int = 0
        for match in matches {
            // if we don't have two groups, something went wrong
            if match.numberOfRanges < 2 { continue }

            let instance = original.substring(with: match.range)
            let title = "[Preview: \(original.substring(with: match.range(at: 1)))]"
            let link = original.substring(with: match.range(at: 2))

            // every time we replace text, the line shifts
            // record the number of characters to the left
            // that the text shifted, so we can "undo"
            // this the next time the loop is run.
            let updatedRange = NSRange(location: match.range.location - locationCharShift, length: match.range.length)
            
            if enabled {
                locationCharShift += instance.count
                
                // add image, then remove brackets and url
                let attachment = AsyncImageAttachment(imageURL: URL(string: link))
                line.append(NSAttributedString(attachment: attachment))
                line.replaceCharacters(in: updatedRange, with: "")
            } else {
                locationCharShift += instance.count - title.count

                // add link, then remove brackets and url
                line.addAttributes([.link: link], range: updatedRange)
                line.replaceCharacters(in: updatedRange, with: title)
            }
        }

        return line
    }
}

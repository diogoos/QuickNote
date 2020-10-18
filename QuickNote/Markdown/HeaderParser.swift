//
//  HeaderParser.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

struct HeaderParser: MarkdownParser {
    var basePixel: Int = 16
    var levelTable: [Int: Double] = [
        1: 2,
        2: 1.5,
        3: 1.25,
        4: 1,
        5: 0.875,
        6: 0.85
    ]

    private func fontSize(level: Int) -> CGFloat {
        precondition(level > 0 && level <= 6, "Invalid heading level \(level): must be between 1-6")
        return CGFloat(levelTable[level]! * Double(basePixel))
    }

    func line(_ line: String) -> NSAttributedString? {
        if line.count < 2 { return nil } // at *minimum* we need a # and a space (2 characters)
        if !line.starts(with: "#") { return nil } // if we don't have any #, continue

        var lastChar: Character = "#"
        var charIndex = 0

        // count how many # we have in the beginning of the line
        repeat {
            lastChar = line[line.index(line.startIndex, offsetBy: charIndex)]
            charIndex += 1
        } while lastChar == "#"
        charIndex -= 1

        if charIndex > 6 { return nil } // nothing beyond h6 exists

        // remove leading #s from string
        let startIndex = line.index(line.startIndex, offsetBy: charIndex+1)
        let value = String(line[startIndex..<line.endIndex])

        // convert into rich text
        let result = NSMutableAttributedString(string: value, attributes: [
            NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: fontSize(level: charIndex))
        ])
        if charIndex < 3 {
            result.append(ThematicBreakAttachment)
        }
        return NSAttributedString(attributedString: result)
    }

    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString {
        return richText
    }
}

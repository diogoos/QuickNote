//
//  ListParser.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/18/20.
//

import Cocoa

struct ListParser: MarkdownParser {
    var bodyParser: BodyParser = BodyParser()

    func line(_ line: String) -> NSAttributedString? {
        if line.count < 2 { return nil }

        let isBulleted = line.trimmingCharacters(in: .whitespaces).starts(with: "* ")
        if isBulleted {
            var components = line.components(separatedBy: "* ")
                components.remove(at: 0)
            let line = components.joined(separator: "* ")

            let bullet = bodyParser.line("\u{2022} ")!
            let formattedLine = bodyParser.line(line)!

            let attributedString = NSMutableAttributedString()
            attributedString.append(bullet)
            attributedString.append(formattedLine)
            return attributedString as NSAttributedString
        }

        return nil
    }
    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString { richText }
}

//
//  BodyParser.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Foundation
import Cocoa

struct BodyParser: MarkdownParser {
    var basePixel: Int = 16
    let sizeRatio: Double = 0.875
    func line(_ line: String) -> NSAttributedString? {
        NSAttributedString(string: line, attributes: [
            NSAttributedString.Key.font: NSFont.systemFont(ofSize: CGFloat(Double(basePixel) * sizeRatio))
        ])
    }
    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString { richText }
}

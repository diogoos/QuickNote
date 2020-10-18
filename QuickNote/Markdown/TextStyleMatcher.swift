//
//  TextStyle.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/18/20.
//

import Foundation

struct TextStyleMatcher {
    let regexString: String
    let regexOptions: NSRegularExpression.Options
    let delimiter: String
    let attributes: [NSAttributedString.Key: Any]

    init(regexString: String,
         regexOptions: NSRegularExpression.Options = [],
         delimiter: String,
         attributes: [NSAttributedString.Key: Any]) {
        self.regexString = regexString
        self.regexOptions = regexOptions
        self.delimiter = delimiter
        self.attributes = attributes
    }

    var regex: NSRegularExpression { try! NSRegularExpression(pattern: regexString, options: regexOptions) }

    func match(in text: NSMutableAttributedString) -> NSMutableAttributedString {
        let matchRanges = regex.matches(in: text.string,
                                        options: [],
                                        range: NSRange(location: 0, length: text.string.utf16.count))

        for (idx, match) in matchRanges.enumerated() {
            // get the range for the match
            var range = match.range

            // we removed x characters every loop run, so adjust the range accordingly
            let locationShift = idx * delimiter.count * -2
            range = NSRange(location: range.location + locationShift, length: range.length) // calculate the new range

            // apply attributes
            text.addAttributes(attributes, range: range)

            // remove the labels
            text.mutableString.replaceOccurrences(of: delimiter, with: "", options: [], range: range)
        }

        return text
    }
}

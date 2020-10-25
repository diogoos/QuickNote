//
//  NSRegularExpression+StaticString.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/24/20.
//

import Foundation

extension NSRegularExpression {
    convenience init(staticPattern: StaticString, options: NSRegularExpression.Options) {
        do {
            try self.init(pattern: "\(staticPattern)", options: options)
        } catch {
            fatalError("Found invalid regular expression: '\(staticPattern)'")
        }
    }
}

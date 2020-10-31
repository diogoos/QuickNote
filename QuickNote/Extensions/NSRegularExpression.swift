//
//  NSRegularExpression.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/31/20.
//

import Foundation

extension NSRegularExpression {
    /// Initalize a regular expression from a StaticString, a string that must be hard-coded in the program.
    /// This expression does not throw on failure - it instead results in a `fatalError()`
    /// Because of this, when debugging, it is crucial to make sure that all regular expressions are valid.
    convenience init(staticPattern: StaticString, options: NSRegularExpression.Options) {
        do {
            try self.init(pattern: "\(staticPattern)", options: options)
        } catch {
            fatalError("Found invalid regular expression: '\(staticPattern)'")
        }
    }
}

//
//  NSFont+systemFont.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/18/20.
//

import Cocoa

extension NSFont {
    static func italicSystemFont(ofSize size: CGFloat) -> NSFont {
        let regularFont = NSFont.systemFont(ofSize: size)
        let italicDescriptior = regularFont.fontDescriptor.withSymbolicTraits(.italic)
        return NSFont(descriptor: italicDescriptior, size: size)!
    }

    static func boldItalicSystemFont(ofSize size: CGFloat) -> NSFont {
        let regularFont = NSFont.boldSystemFont(ofSize: size)
        let italicDescriptior = regularFont.fontDescriptor.withSymbolicTraits([.bold, .italic])
        return NSFont(descriptor: italicDescriptior, size: size)!
    }
}

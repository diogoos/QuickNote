//
//  NSWindow+Standard.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

extension NSWindow {
    static let standardWindow: NSWindow = {
        let contentRect = NSRect(x: 196, y: 240, width: 420, height: 270)
        let window = NSWindow(contentRect: contentRect,
                              styleMask: [.titled, .resizable, .closable, .miniaturizable, .titled],
                              backing: .buffered,
                              defer: true)
        window.isReleasedWhenClosed = false
        return window
    }()
}

//
//  Coordinator.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var windowController: NSWindowController { get set }

    func start()
    func start<T: NSViewController & Storyboarded>(_ controller: T.Type)
}

extension Array where Element == Coordinator {
    func forWindow(_ window: NSWindow?) -> Element? {
        self.first(where: { $0.windowController.window == window })
    }
}

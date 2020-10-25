//
//  Storyboarded.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: NSViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        let identifier = NSStoryboard.SceneIdentifier(className)
        if let controller = storyboard.instantiateController(withIdentifier: identifier) as? Self {
            return controller
        } else {
            fatalError("View controller with identifier '\(className)' was not found in bundle.")
        }
    }
}

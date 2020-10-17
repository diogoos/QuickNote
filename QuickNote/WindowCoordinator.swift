//
//  WindowCoordinator.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

class WindowCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var windowController: NSWindowController
    var representedObject: Any?

    init(windowController: NSWindowController, representedObject: Any?) {
        self.windowController = windowController
        self.representedObject = representedObject
    }

    func

    start<T: NSViewController & Storyboarded>(_ controller: T.Type) {
        let vc = controller.instantiate()
        windowController.contentViewController = vc
        windowController.contentViewController?.representedObject = representedObject
    }

    func start() {
        start(EditorViewController.self)
    }

    static func detachWindow(from notification: Notification) {
        if notification.object == nil { return }
        guard let closedWindow = notification.object as? NSWindow else { return }
        guard let delegate = NSApp.delegate as? AppDelegate else { return }

        guard let windowCoordinatorIndex = delegate.coordinators.firstIndex(where: {
            $0.windowController.window == closedWindow
        }) else {
            if let closedWindow = delegate.previewWindows.firstIndex(of: closedWindow) {
                delegate.previewWindows.remove(at: closedWindow)
            }

            delegate.editorItem.state = .on
            delegate.viewerItem.state = .off
            delegate.splitItem.state = .off
            delegate.separateItem.state = .off
            return
        }

        delegate.previewWindows.forEach { pWindow in
            let owner = (pWindow.contentViewController as? ViewerViewController)?.owner
            if owner == closedWindow.identifier.hashValue {
                pWindow.close()
            }
        }
        
        (NSApp.delegate as! AppDelegate).coordinators.remove(at: windowCoordinatorIndex)
    }
}

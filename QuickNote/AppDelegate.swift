//
//  AppDelegate.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/16/20.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var coordinators = [Coordinator]()
    var previewWindows = [NSWindow]()

    @IBOutlet weak var viewMenu: NSMenu!
    @IBOutlet var viewerItem: NSMenuItem!
    @IBOutlet var editorItem: NSMenuItem!
    @IBOutlet var splitItem: NSMenuItem!
    @IBOutlet var separateItem: NSMenuItem!

    var notificationObserver: NSObjectProtocol?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        notificationObserver = NotificationCenter.default.addObserver(forName: NSWindow.willCloseNotification,
                                                                      object: nil,
                                                                      queue: nil,
                                                                      using: WindowCoordinator.detachWindow(from:))

        viewMenu.delegate = self
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func requestView(sender: NSMenuItem) {
        switch sender.title {
        case "Editor only": setView(for: NSApp.keyWindow, to: EditorViewController.self)
        case "Viewer only": setView(for: NSApp.keyWindow, to: ViewerViewController.self)
        case "Split view":  setView(for: NSApp.keyWindow, to: SplitViewController.self)
        case "Separate windows": instantiateSeparateWindows()
        default: break
        }

        editorItem.state = .off
        viewerItem.state = .off
        splitItem.state = .off
        separateItem.state = .off
        sender.state = .on
    }

    func setView<T: NSViewController & Storyboarded>(for window: NSWindow?, to windowType: T.Type) {
        if let coordinator = coordinators.forWindow(window) {
            previewWindows.forEach { pWindow in
                let owner = (pWindow.contentViewController as? ViewerViewController)?.owner
                if owner == window?.identifier.hashValue {
                    pWindow.close()
                }

            }
            coordinator.start(windowType)
        }
    }

    func instantiateSeparateWindows() {
        // grab the current window & its coordinator
        guard let keyWindow = NSApp.keyWindow else { return }
        guard let coordinator = coordinators.forWindow(keyWindow) else { return }

        // make sure that there isn't already a separate window
        let ownedWindows = previewWindows.filter({
            let owner = ($0.contentViewController as? ViewerViewController)?.owner
            return owner == keyWindow.identifier.hashValue
        })
        if ownedWindows.count > 0 {
            ownedWindows.first?.makeKeyAndOrderFront(self)
            return
        }

        // make the current view an editor
        coordinator.start(EditorViewController.self)

        // create a window
        let contentRect = NSRect(x: 196, y: 240, width: 420, height: 270)
        let window = NSWindow(contentRect: contentRect,
                              styleMask: [.titled, .resizable, .closable, .miniaturizable],
                              backing: .buffered,
                              defer: true)

        window.title = "Preview for \(keyWindow.representedURL?.lastPathComponent ?? "Untitled")"
        window.makeKeyAndOrderFront(nil)
        window.isReleasedWhenClosed = false

        window.contentViewController = ViewerViewController.instantiate()
        window.contentViewController?.representedObject = keyWindow.contentViewController?.representedObject
        (window.contentViewController as? ViewerViewController)?.owner = keyWindow.identifier.hashValue

        // sync the contents of both windows
        (coordinator.windowController.contentViewController as? EditorViewController)?.changeCallback = {
            window.contentViewController?.representedObject = QuickNote(text: $0)
        }

        previewWindows.append(window)
    }
}

extension AppDelegate: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        if coordinators.forWindow(NSApp.keyWindow) == nil {
            editorItem.isHidden = true
            viewerItem.isHidden = true
            splitItem.isHidden = true
            separateItem.isHidden = false
        } else {
            editorItem.isHidden = false
            viewerItem.isHidden = false
            splitItem.isHidden = false
            separateItem.isHidden = false
        }
    }
}

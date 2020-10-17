//
//  Document.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/16/20.
//

import Cocoa


class QuickNote: Codable {
    var text: String

    init(text: String) {
        self.text = text
    }

    convenience init() {
        self.init(text: "")
    }
}


class Document: NSDocument {
    var note = QuickNote()

    override class var autosavesInPlace: Bool { true }

    override func makeWindowControllers() {
        let windowController = NSWindowController(window: NSWindow.standardWindow)
        windowController.synchronizeWindowTitleWithDocumentName()
        self.addWindowController(windowController)

        let coordinator = WindowCoordinator(windowController: windowController, representedObject: note)
        coordinator.start()
        (NSApp.delegate as! AppDelegate).editorItem.state = .on
        (NSApp.delegate as! AppDelegate).coordinators.append(coordinator)
    }

    override func data(ofType typeName: String) throws -> Data {
        return Data(note.text.utf8)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        guard let loadedString = String(data: data, encoding: .utf8) else {
            throw DocumentError.invalidData
        }
        note = QuickNote(text: loadedString)
    }
}

enum DocumentError: Error {
    case invalidData
}

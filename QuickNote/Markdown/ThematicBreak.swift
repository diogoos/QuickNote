//
//  ThematicBreak.swift
//  QuickNote
//
//  Created by Diogo Silva on 10/17/20.
//

import Cocoa

struct ThematicBreakParser: MarkdownParser {
    func line(_ line: String) -> NSAttributedString? {
        if !line.contains("--") { return nil }
        let line = line.trimmingCharacters(in: .whitespacesAndNewlines)
        if line.trimmingCharacters(in: .whitespaces).filter({ $0 != "-" }).count == 0 {
            return ThematicBreakAttachment
        }
        return nil
    }

    func whole(_ richText: NSMutableAttributedString) -> NSMutableAttributedString {
        richText
    }
}

// swiftlint:disable:next identifier_name
let ThematicBreakAttachment: NSAttributedString = {
    let textAttachment = NSTextAttachment()
    textAttachment.attachmentCell = ThematicBreakAttachmentCell()
    return NSAttributedString(attachment: textAttachment)
}()

class ThematicBreakAttachmentCell: NSTextAttachmentCell {
    override func cellFrame(for textContainer: NSTextContainer,
                            proposedLineFragment lineFrag: NSRect,
                            glyphPosition position: NSPoint,
                            characterIndex charIndex: Int) -> NSRect {
        NSRect(x: 0, y: 0, width: lineFrag.size.width, height: 15)
    }

    override func draw(withFrame cellFrame: NSRect, in controlView: NSView?) {
        NSColor.textColor.withAlphaComponent(0.5).set()

        var widthFrame = cellFrame.insetBy(dx: 0, dy: 0)
        widthFrame.origin.y += 15/2
        widthFrame.size.height = 1.5
        widthFrame.fill()
    }
}

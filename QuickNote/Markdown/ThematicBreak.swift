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

let ThematicBreakAttachment: NSAttributedString = {
    let textAttachment = NSTextAttachment()
    textAttachment.attachmentCell = ThematicBreakAttachmentCell()
    return NSAttributedString(attachment: textAttachment)
}()

class ThematicBreakAttachmentCell: NSTextAttachmentCell {
    override func cellFrame(for textContainer: NSTextContainer, proposedLineFragment lineFrag: NSRect, glyphPosition position: NSPoint, characterIndex charIndex: Int) -> NSRect {
        return NSMakeRect(0, 0, lineFrag.size.width, 15)
    }

    override func draw(withFrame cellFrame: NSRect, in controlView: NSView?) {
        NSColor.white.withAlphaComponent(0.5).set()

        var widthFrame = NSInsetRect(cellFrame, 2, 0)
        widthFrame.origin.y += 15/2
        widthFrame.size.height = 1.5
//        widthFrame.size.width -= 30

        widthFrame.fill()
    }
}


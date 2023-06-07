//
//  AsyncImageAttachment.swift
//  QuickNote
//
//  Created by Diogo Silva on 6/7/23.
//

import Foundation
import AppKit

/// An image text attachment that gets loaded from a remote URL
class AsyncImageAttachment: NSTextAttachment {
    /// Remote URL for the image
    let imageURL: URL?
    

    private var setImage = false
    private var isDownloading = false
    private weak var textContainer: NSTextContainer?
    
    init(imageURL: URL? = nil) {
        self.imageURL = imageURL
        super.init(data: nil, ofType: nil)
        self.image = NSImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        if let originalImageSize = image?.size {
            return CGRect(origin: .zero, size: originalImageSize)
        }
        
        // If we return .zero, the image(forBounds:textContainer:characterIndex:) function won't be called
        let placeholderSize = CGSize(width: 10, height: 10)
        return CGRect(origin: .zero, size: placeholderSize)
    }
    
    
    override func image(forBounds imageBounds: CGRect, textContainer: NSTextContainer?, characterIndex charIndex: Int) -> NSImage? {
        if setImage, let image = image { return image }
        self.textContainer = textContainer
        
        guard !isDownloading else { return nil }
        
        guard let imageURL = imageURL else {
            self.image = NSImage(named: NSImage.cautionName)
            return self.image
        }

        isDownloading = true
        
        URLSession.shared.dataTask(with: URLRequest(url: imageURL), completionHandler: { [weak self] data, res, err in
            guard let self = self else { return }
            defer { self.isDownloading = false }
            
            
            if let data = data, let downloadedImage = NSImage(data: data) {
                self.image = downloadedImage
            } else {
                self.image = NSImage(named: NSImage.cautionName)
            }
            
            
            self.setImage = true

            DispatchQueue.main.async {
                if let layoutManager = self.textContainer?.layoutManager, let textStorage = layoutManager.textStorage {
                    var ranges: [NSRange] = []
                    textStorage.enumerateAttribute(.attachment, in: NSRange(location: 0, length: textStorage.length), options: [], using: { (attribute, range, _) in
                        if let foundAttribute = attribute as? NSTextAttachment, foundAttribute === self {
                            ranges.append(range)
                        }
                    })
                    ranges.forEach { range in
                        layoutManager.invalidateLayout(forCharacterRange: range, actualCharacterRange: nil)
                    }
                }
            }
        }).resume()
        
        return nil
    }
}

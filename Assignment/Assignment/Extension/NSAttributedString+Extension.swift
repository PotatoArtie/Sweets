//
//  NSAttributedString.swift
//  Assignment
//
//  Created by Atlas on 2022/08/24.
//

import UIKit

extension NSAttributedString {
    func changeTextColor(color: UIColor, text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)

        var range = NSRange(location: 0, length: self.length)
        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: text, options: [], range: range)
            if (range.location != NSNotFound) {
                attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: range.location, length: text.count))
                range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
            }
        }

        return attributedString
    }
    
    func changeTextFont(font: UIFont, text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)

        var range = NSRange(location: 0, length: self.length)
        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: text, options: [], range: range)
            if (range.location != NSNotFound) {
                attributedString.addAttribute(.font, value: font, range: NSRange(location: range.location, length: text.count))
                range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
            }
        }

        return attributedString
    }
    
}

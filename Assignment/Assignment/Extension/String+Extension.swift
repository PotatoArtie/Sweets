//
//  String+Extension.swift
//  Assignment
//
//  Created by Atlas on 2022/08/22.
//

import UIKit

extension String {

    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "" )
    }
    
    func convertString(text: String, highlightColor: UIColor = .opggDarkishPink, textColor : UIColor = .opggDarkGrey) -> NSMutableAttributedString {
        
        let attributedStr = NSMutableAttributedString(string: self)
        
        attributedStr.addAttribute(.foregroundColor, value: textColor, range: (self as NSString).range(of:self))

        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightColor, range: (self as NSString).range(of: text))

        return attributedStr
        
    }
    
  
}


//SFProText-Bold

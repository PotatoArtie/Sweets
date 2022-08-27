//
//  Int+Extension.swift
//  Assignment
//
//  Created by Atlas on 2022/08/22.
//

import Foundation

extension Int {
    var day: Int {
        self / 86400
    }
    var hour: Int {
        self / 3600
    }
    var minute: Int {
        (self % 3600) / 60
    }
    var seconds: Int {
        (self % 60)
    }
    
    func toMMFormat() -> String {
        let mm = self / 60
        let sec = self % 60
        
        let mmString: String = (self / 60) < 10 ? "0\(mm)" : "\(mm)"
        let secondString: String = sec < 10 ? "0\(sec)" : "\(sec)"
        return "\(mmString):\(secondString)"
    }
    
    func prevPlaytime() -> String {
        
        let currentDate = Date()
        let now = Date().timeIntervalSince1970
        let currentTime = Int(now)
        let differTime = currentTime-self
        let expirationDate = currentDate.addingTimeInterval(TimeInterval(differTime))
        let remainUTC = expirationDate.timeIntervalSince(currentDate)
        let remainUTCInteger = Int(remainUTC)

        if remainUTCInteger.day > 6 {
            let playedDate = Date(timeIntervalSince1970: TimeInterval(self))
            return playedDate.string(from: "yy.MM.dd")
        }else if remainUTCInteger.day != 0 {
            return "\(remainUTCInteger.day)일 전"
        }else if remainUTCInteger.hour != 0 {
            return "\(remainUTCInteger.hour)시간 전"
        }else if remainUTCInteger.minute != 0 {
            return "\(remainUTCInteger.minute)분 전"
        }else{
            return "방금 전"
        }
    }
    
    func convertCurrency(style : NumberFormatter.Style = .decimal) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        
        return numberFormatter.string( from: self as NSNumber)!
    }
}

//
//  Date+Extension.swift
//  Assignment
//
//  Created by Atlas on 2022/08/22.
//

import Foundation

extension Date {
    func string(from fotmat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fotmat
        return dateFormatter.string(from: self)
    }
}

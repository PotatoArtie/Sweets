//
//  InfoManager.swift
//  Assignment
//
//  Created by Dongju on 2022/08/19.
//

import Foundation

class InfoManager {
    
    class func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }
    
}

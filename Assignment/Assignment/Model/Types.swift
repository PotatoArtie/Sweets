//
//  Types.swift
//  Assignment
//
//  Created by Atlas on 2022/08/22.
//

import UIKit

enum ScoreBadgeType: String, CaseIterable {
    case ace = "ACE"
    case mvp = "MVP"
    
    static func getBadgeColor(_ badge: String) -> UIColor {
        
        if badge == ace.rawValue {
            return .opggOrangeYellow
        }else if badge == mvp.rawValue {
            return .opggOrangeYellow
        }else{
            return .white
        }
        
    }
}

enum PositionType: String, CaseIterable {
    case topPosition = "Top"
    case midPosition = "Middle"
    case bottomPosition = "Bottom"
    case junglePosition = "Jungle"
    case suppoert = "Support"
    
    static func getImageURLByPosition(positionName: String) -> String {
        if positionName == topPosition.rawValue {
            return "iconLolTop"
        }else if positionName == midPosition.rawValue {
            return "iconLolMid"
        }else if positionName == bottomPosition.rawValue {
            return "iconLolBot"
        }else if positionName == junglePosition.rawValue {
            return "iconLolJng"
        }else if positionName == suppoert.rawValue {
            return "iconLolSup"
        }else{
            return "iconLolAll"
        }
    }
}


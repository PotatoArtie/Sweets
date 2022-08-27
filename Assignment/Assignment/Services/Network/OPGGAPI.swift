//
//  OPGGAPI.swift
//  Assignment
//
//  Created by Dongju on 2022/08/19.
//

import Moya
import UIKit

public enum Opgg {
    case summoner(name: String)
    case gameInfomation(name: String, lastMatch: Int64)
}

extension Opgg: TargetType {
    public var baseURL: URL {
        return URL(string: OPGGKey.baseURL!)!
    }
    
    public var path: String {
        switch self {
        case let .summoner(name):
            return "\(name)"
        case let .gameInfomation(name, _):
            return "\(name)/matches"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .summoner, .gameInfomation:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .summoner, .gameInfomation:
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding(destination: .queryString))
        }
        
    }
    
    public var headers: [String : String]? {
        return [:]
    }
    
    
}

extension Opgg {
    public var parameters: [String : Any] {
        switch self {
        case .summoner:
            return [:]
        case let .gameInfomation(_, lastMatch):
            return ["lastMatch" : lastMatch]
        }
    }
}

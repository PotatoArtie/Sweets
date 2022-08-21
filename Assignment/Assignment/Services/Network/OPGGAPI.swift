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
}

extension Opgg: TargetType {
    public var baseURL: URL {
        print(URL(string: OPGGKey.baseURL!)!)
        return URL(string: OPGGKey.baseURL!)!
    }
    
    public var path: String {
        switch self {
        case let .summoner(name):
            return "\(name)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .summoner:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .summoner:
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
        }
    }
}

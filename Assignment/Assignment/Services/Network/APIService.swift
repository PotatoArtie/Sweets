//
//  APIService.swift
//  Assignment
//
//  Created by Dongju on 2022/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class APIService {
    static let shared = APIService()
    let plugin = NetworkActivityPlugin { (changeType, targetType) in
        
        switch changeType {
        case .began:
            if let target = targetType as? Opgg {
                switch target {
                case .summoner(_):
                    DispatchQueue.main.async{
                        IndicatorView.shared.show()
                        
                    }
                default :
                    break
                }
            }
            
        case .ended:
            DispatchQueue.main.async{
                IndicatorView.shared.hide()
            }
            break
        }
        
    }
    
    lazy var provider = APIProvider(plugin)
    
    func request<T: Decodable>(_ target: Opgg,
                               expectingReturnType: T.Type ) -> PrimitiveSequence<SingleTrait, Result<T, NetworkException>> {
        
        return provider.request(target)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .serverErrorHandler(expectingReturnType: expectingReturnType)
    }
    
}

public struct ErrorTranperDTO: Codable {
    public let timestamp, gid, statusCode, statusName: String
    public let path, errorMessageCode, errorMessage, errorClassName: String
    public let errorStack: [String]?
}

public enum NetworkException: Error {
    case errorStatusCode(ErrorTranperDTO)
    case errorTypeCasting
}

extension Moya.Response {
    
    public func responseResult<T: Decodable>(expectingReturnType: T.Type) -> Result<T, NetworkException>{
        switch self.statusCode {
        case 200...299:
            if expectingReturnType.self == String.self {
                return Result.success(String(decoding: data, as: UTF8.self) as! T)
            } else {
                do {
                    let model = try JSONDecoder().decode(expectingReturnType.self, from: self.data)
                    return Result.success(model)
                }
                catch {
                    return Result.failure(.errorTypeCasting)
                }
            }
        default:
            return Result.failure(.errorTypeCasting)
        }
    }
}


extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    public func serverErrorHandler<T: Decodable>(expectingReturnType: T.Type) -> Single<Result<T, NetworkException>> {
        
        return flatMap { response -> Single<Result<T, NetworkException>> in
            let result = response.responseResult(expectingReturnType: expectingReturnType)
            
            // 에러일 경우 에러 팝업처리
            switch result {
            case .failure(_):
                break
            default: break
            }
            
            return Single.just(result)
        }
    }
}

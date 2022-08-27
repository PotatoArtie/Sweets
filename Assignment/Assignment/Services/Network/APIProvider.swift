//
//  APIProvider.swift
//  Assignment
//
//  Created by Dongju on 2022/08/21.
//

import RxSwift
import Moya
import RxMoya

public class APIProvider {
    lazy var provider = MoyaProvider<Opgg>(plugins: [RequestLoggingPlugin(), networkPlugin])
    
    let networkPlugin: NetworkActivityPlugin
    
    public init(_ networkPlugin: NetworkActivityPlugin = NetworkActivityPlugin { _, _ in }) {
        self.networkPlugin = networkPlugin
    }
    
    public func request(_ target: Opgg) -> PrimitiveSequence<SingleTrait, Response> {
        return provider.rx.request(target)
    }
    
}

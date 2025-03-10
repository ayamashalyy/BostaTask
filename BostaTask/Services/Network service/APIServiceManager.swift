//
//  APIServiceManager.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import Foundation
import Moya
import RxSwift
import RxMoya

class APIServiceManager {
    private let provider = MoyaProvider<APIService>()
    
    func fetch<T: Decodable>(_ target: APIService, model: T.Type) -> Single<T> {
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(T.self)
    }
}

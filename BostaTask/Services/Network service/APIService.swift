//
//  APIService.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import Foundation
import Moya

enum APIService {
    case getUsers
    case getAlbums(userId: Int)
    case getPhotos(albumId: Int)
}

extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: APIEndpoints.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getAlbums(userId: _):
            return "/albums"
        case .getPhotos(albumId: _):
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .getAlbums(let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.default)
        case .getPhotos(let albumId):
            return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

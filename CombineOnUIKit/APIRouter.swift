//
//  APIRouter.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 13/08/2022.
//

import Foundation

enum APIRouter {
    static let baseURL = URLConstant.getBaseUrl()
    
    //MARK: Cases for each API request
    case login(loginRequest:LoginRequest)
    case users
    case posts(userId:Int)
    case comment(postId:Int)
    case getVideos
    
    
    //MARK: Endpoint for each API
    var path: String{
        switch self {
        case .login(_):
            return "/oauth/token"
        case .users:
            return "/users"
        case .posts(let userId):
            return "/posts?userId=\(userId)"
        case .comment(let postId):
            return "/comments?postId=\(postId)"
        default:
            return ""
        }
    }
    
    
    //MARK: HTTPMethod
    var method: HTTPMethod{
        switch self {
        case .users:
            return .get
        default:
            return .post
        }
    }
    
    //MARK: URL Type
    var urlType: URLType{
        switch self {
        case .users, .posts, .comment:
            return .queryString
        default:
            return .post
        }
    }
    
    
    //MARK: Encoding
//    var encoding: ParameterEncoding{
//        switch method {
//        default:
//             return URLEncoding.default
//        }
//    }
    
    
    //MARK: Parameters, That need to be encoded
    var parameters: Parameters? {
        switch self {
        case .login(let loginRequest):
            return [APIParameterKey.grantType:  loginRequest.grant_type,
                    APIParameterKey.username:   loginRequest.username,
                    APIParameterKey.password:   loginRequest.password
            ]
        default:
            return nil
        }
    }
    
    
    //MARK: Body
    var body: Parameters?{
        switch self {
        case .login:
            return nil
        default:
            return nil
        }
    }
    
    //MARK: Request Body, Need to check if it works then remove body var above.
    var requestBody: Encodable?{
        switch self {
        case .login(let loginRequest): return loginRequest
        default: return nil
        }
    }
    
    
    //MARK: Additional Headers
    var headers: HTTPHeaders? {
        switch self {
        case .login(_):
            return [
                HTTPHeaderField.contentType.rawValue:       HTTPHeaderValue.contentType.rawValue,
                HTTPHeaderField.channelKey.rawValue:        HTTPHeaderValue.channelKey.rawValue
            ]
        case .posts:
            return nil
        default:
            return [
                HTTPHeaderField.contentType.rawValue:       HTTPHeaderValue.applicationJson.rawValue,
//                HTTPHeaderField.channelKey.rawValue:        HTTPHeaderValue.channelKey.rawValue
            ]
        }
    }
    
    //MARK: Time out
    var timeoutInterval: Double{
        switch self {
        default:
            return 300
        }
    }
    
}

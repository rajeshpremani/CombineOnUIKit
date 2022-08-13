//
//  APIRouter.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 13/08/2022.
//

import Foundation
//
//enum APIRouter {
//    static let baseURL = URLConstant.getBaseUrl()
//
//    //MARK: Cases for each API request
//    case login(loginRequest:LoginRequest)
//    case getVideos
//
//
//    //MARK: Endpoint for each API
//    var path: String{
//        switch self {
//        case .login(_):
//            return "/oauth/token"
//        default:
//            return ""
//        }
//    }
//
//
//    //MARK: HTTPMethod
//    var method: HTTPMethod{
//        switch self {
//        default:
//            return .post
//        }
//    }
//
//
//    //MARK: Encoding
//    var encoding: ParameterEncoding{
//        switch method {
//        default:
//             return URLEncoding.default
//        }
//    }
//
//
//    //MARK: Parameters
//    var parameters: Parameters? {
//        switch self {
//        case .login(let loginRequest):
//            return [APIParameterKey.grantType:  loginRequest.grant_type,
//                    APIParameterKey.username:   loginRequest.username,
//                    APIParameterKey.password:   loginRequest.password
//            ]
//        default:
//            return nil
//        }
//    }
//
//
//    //MARK: Body
//    var body: Parameters?{
//        switch self {
//        case .login:
//            return nil
//        default:
//            return nil
//        }
//    }
//
//
//    //MARK: Additional Headers
//    var additionalHeaders: HTTPHeaders? {
//        switch self {
//        case .login(_):
//            return HTTPHeaders([
//                HTTPHeaderField.contentType.rawValue:       HTTPHeaderValue.contentType.rawValue,
//                HTTPHeaderField.channelKey.rawValue:        HTTPHeaderValue.channelKey.rawValue
//            ])
//
//        default:
//            return HTTPHeaders([
//                HTTPHeaderField.contentType.rawValue:       HTTPHeaderValue.applicationJson.rawValue,
//                HTTPHeaderField.channelKey.rawValue:        HTTPHeaderValue.channelKey.rawValue
//            ])
//        }
//    }
//
//    //MARK: Time out
//    var timeout: TimeInterval{
//        switch self {
//        default:
//            return 300
//        }
//    }
//
//}

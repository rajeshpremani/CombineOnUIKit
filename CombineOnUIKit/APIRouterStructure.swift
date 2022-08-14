//
//  APIRouterStructure.swift
//  ExamOk
//
//  Created by Rajesh Kumar Sahil on 29/08/2021.
//

import Foundation


typealias HTTPHeaders = [String:String]
typealias Parameters = [String:String]


struct APIRouterStructure{
    let apiRouter: APIRouter
    
    func asURLRequest() -> URLRequest{

        var request:URLRequest
        
        if let url = URL(string:APIRouter.baseURL.appendingPathComponent(apiRouter.path).absoluteString.removingPercentEncoding ?? ""), apiRouter.urlType == .queryString{
            request = URLRequest(url: url)
//            request.httpMethod = apiRouter.method.rawValue
//            request.timeoutInterval = apiRouter.timeoutInterval
//            request.headers = apiRouter.headers
        }else{
            request = URLRequest(url: APIRouter.baseURL.appendingPathComponent(apiRouter.path))
            request.httpMethod = apiRouter.method.rawValue
            request.timeoutInterval = apiRouter.timeoutInterval
            request.headers = apiRouter.headers
        }
        
        
//        if let body = apiRouter.body{
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
//            } catch {
////                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//            }
//        }
        
        if let requestBody = apiRouter.requestBody{
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            } catch {
//                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        //Parameters
        if let parameters = apiRouter.parameters{
            //TODO: ENCODE PARAMS
        }
        
        Print.request(request: request)
        return request
    }
}

enum HTTPMethod:String{
    case post
    case get
}

enum URLType:String{
    case queryString
    case post
}

extension URLRequest{
    
    var headers: [String:String]? {
        set{
            self.allHTTPHeaderFields = newValue
        }
        get{
            self.allHTTPHeaderFields
        }
    }
}

//
//
//struct APIRouterStructure : URLRequestConvertible{
//    
//    let apiRouter: APIRouter
//    
//    func asURLRequest() throws -> URLRequest {
//        var request = URLRequest(url: APIRouter.baseURL.appendingPathComponent(apiRouter.path))
//        request.httpMethod = apiRouter.method.rawValue
//        request.timeoutInterval = apiRouter.timeout
//        request.headers = headers()
//        
//        //Body
//        if let body = apiRouter.body{
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
//            } catch {
//                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//            }
//        }
//        
//        //Parameters
//        if let parameters = apiRouter.parameters{
//            request = try apiRouter.encoding.encode(request, with: parameters)
//        }
//        
//        Print.request(request: request)
//        return request
//    }
//    
//    private func headers() -> HTTPHeaders{
//        var headersDict = [String:String]()
//        
//        if let additionalHeaders = apiRouter.additionalHeaders{
//            let additionalHeaderDict = additionalHeaders.dictionary
//            additionalHeaderDict.forEach{ (key, value) in
//                headersDict[key] = value
//            }
//        }
//        
//        return HTTPHeaders(headersDict)
//    }
//}

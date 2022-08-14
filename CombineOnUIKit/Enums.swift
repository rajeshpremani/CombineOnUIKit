//
//  Enums.swift
//  ExamOk
//
//  Created by Rajesh Kumar Sahil on 29/08/2021.
//

import Foundation


enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType    = "Content-Type"
    case contentLength  = ""
    case accept         = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case token          = "token"
    case locale         = "locale"
    case appVersion     = "app_version"
    case connection     = "Connection"
    case channelKey     = "ChannelKey"
}

enum HTTPHeaderValue: String {
    case contentType = "application/x-www-form-urlencoded"
    case applicationJson = "application/json"
//    case contentLength  = ""
    case accept         = "*/*"
    case acceptEncoding = "gzip, deflate, br"
//    case token          = ""
//    case locale         = ""
//    case appVersion     = ""
    case connection     = "keep-alive"
    case channelKey     = "262fcc734f50ffc7630b8523e0982037fe389cee7f23a7ec5d7764d0c3478374"
}


enum APIError: Error{
    case unexpectedError
    case unauthorized
    case userNotFound
    case postNotFound
}


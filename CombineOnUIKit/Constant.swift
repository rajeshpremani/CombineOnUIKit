//
//  Constant.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 13/08/2022.
//

import Foundation

class URLConstant {
    static func getBaseUrl() -> URL{
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
}


class APIParameterKey{
    static let grantType    = "grant_type"
    static let username     = "username"
    static let password     = "password"
}

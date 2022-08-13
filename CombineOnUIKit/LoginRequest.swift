//
//  LoginRequest.swift
//  ExamOk
//
//  Created by Rajesh Kumar Sahil on 29/08/2021.
//

import Foundation

struct LoginRequest: Codable {
    var grant_type:String = "password"
    var username:String
    var password:String
}

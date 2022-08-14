//
//  LoginRequest.swift
//  ExamOk
//
//  Created by Rajesh Kumar Sahil on 29/08/2021.
//

import Foundation

struct LoginRequest: Encodable {
    var grant_type:String = "password"
    var username:String
    var password:String
}



//MOCK
struct User: Decodable {
    var id:Int
    var name:String
}

struct Post: Decodable {
    var id:Int
    var userId:Int
    var title:String
    var body:String
}

struct Comment: Decodable {
    var id:Int
    var postId:Int
    var email:String
}



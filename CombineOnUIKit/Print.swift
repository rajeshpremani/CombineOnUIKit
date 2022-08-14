//
//  Print.swift
//  ExamOk
//
//  Created by Rajesh Kumar Sahil on 29/08/2021.
//

import Foundation


class Print{
    static func request(request:URLRequest){
        print("\n\n\(Log.requestStart.rawValue)\n")
        print("/*************** -- \(String(describing: request.url!)) -- Request Starts ***************/")
        print("\n----------- body Starts -----------")
        if let body = request.httpBody{
            print(String(data: body, encoding: .ascii) ?? "")
        }else {
            print("Body Nil")
        }
        print("\n----------- Headers Start  -----------")
        print("\(String(describing: request.headers))")
//        print("\n----------- HTTPMethod -- \(String(describing: request.method?.rawValue ?? "")) -----------/\n")
        print("/*************** -- \(String(describing: request.url?.lastPathComponent ?? "")) -- Request End *****************/\n")
        print("\(Log.requestEnd.rawValue)\n")
    }

    static func response(urlString:String, data: Data, code:Int){
        if let responseDict = convertToDictionary(data: data){
            print("\n\n\( code == 200 ? Log.responseStart.rawValue : Log.serverStart.rawValue)\n")
            print("/*************** Response Starts ***************/ \n\n\(responseDict) \n\n/*************** \(urlString.components(separatedBy: "/").last ?? "") Response Ends ***************/\n")
            print("\( code == 200 ? Log.responseEnd.rawValue : Log.serverEnd.rawValue)")
        }
    }

    static func error(error:Error){
        print("\n\(Log.errorStart.rawValue) \(error.localizedDescription) \(Log.errorEnd.rawValue)\n")
    }


    private static func convertToDictionary(data: Data) -> [String: Any]? {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        return nil
    }

    enum Log: String {
//        case error      = "❌"
//        case success    = "✅"
//        case request    = "📞"
//        case info       = "ℹ️"
//        case debug      = "💬"
//        case verbose    = "🔬"
//        case warning    = "⚠️"
//        case severe     = "🔥"
//        case start      = "👉"
//        case end        = "👈"

        case serverStart    = "【 ͡🔥 ͜ʖ ͡🔥】 👉"
        case serverEnd      = "👈 【 ͡🔥 ͜ʖ ͡🔥】"
        case errorStart     = "【 ͡❌ ͜ʖ ͡❌】 👉"
        case errorEnd       = "👈 【 ͡❌ ͜ʖ ͡❌】"
        case requestStart   = "【 ͡💤 ͜ʖ ͡💤】 👉"
        case requestEnd     = "👈 【 ͡💤 ͜ʖ ͡💤】"
        case responseStart  = "【 ͡✅ ͜ʖ ͡✅】 👉"
        case responseEnd    = "👈 【 ͡✅ ͜ʖ ͡✅】"
    }
}

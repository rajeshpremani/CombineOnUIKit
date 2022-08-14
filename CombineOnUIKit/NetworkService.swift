//
//  NetworkService.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 13/08/2022.
//

import Foundation
import Combine

class NetworkService{
    
    func getApiData<T:Decodable>(requestUrl:URLRequest, resultType:T.Type){
        URLSession.shared.dataTask(with: requestUrl) { responseData, httpResponse, error in
            if error == nil && responseData != nil {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                } catch let error {
                    debugPrint("Error occurred while decoding", error.localizedDescription)
                }
            }
        }.resume()
    }
    
    
    //TODO: Make generic --Need to fix
    func getAPIData_Combine<T:Decodable>(request:URLRequest) -> AnyPublisher<T, Error>{
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getUser(request:URLRequest) -> AnyPublisher<[User], Error>{
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getPost(request:URLRequest) -> AnyPublisher<[Post], Error>{
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getPost() -> AnyPublisher<[Post], Error>{
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=10")
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map({$0.data})
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
    func getComment(request:URLRequest) -> AnyPublisher<[Comment], Error>{
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}



class AwaitAsyncImp{
    
}

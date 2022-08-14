//
//  NetworkService.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 13/08/2022.
//

import Foundation
import Combine

///Using Combine
class NetworkService_Combine{
    
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
    
    func getComment(request:URLRequest) -> AnyPublisher<[Comment], Error>{
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


/// Using Async and Await to call multiple API
class NetworkService_AwaitAsync{
    func getUser(request:URLRequest) async -> Result<[User], Error>{
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let users = try JSONDecoder().decode([User].self, from: data)
            return .success(users)
        } catch let error {
            return .failure(error)
        }
    }
    
    func getPost(request:URLRequest)  async -> Result<[Post], Error>{
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let post = try JSONDecoder().decode([Post].self, from: data)
            return .success(post)
        } catch let error {
            return .failure(error)
        }
    }
    
    func getComment(request:URLRequest)  async -> Result<[Comment], Error>{
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let comment = try JSONDecoder().decode([Comment].self, from: data)
            return .success(comment)
        } catch let error {
            return .failure(error)
        }
    }
}

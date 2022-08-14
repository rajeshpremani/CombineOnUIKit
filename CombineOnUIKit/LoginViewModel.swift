//
//  LoginViewModel.swift
//  ExamOk
//
//  Created by Rajesh Kumar Sahil on 29/08/2021.
//

import Foundation
import Combine

class LoginViewModel: BaseViewModel {
    
    var user:[User]?
    var comments:[Comment]?
    
    let combine = NetworkService()
    private var subscribers = Set<AnyCancellable>()
    
    
    ///Single API Call using combine
    func getUsers(){
        let request = APIRouterStructure(apiRouter: .users).asURLRequest()
        combine.getUser(request: request).sink { result in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            default:
                print("Completed")
            }
        } receiveValue: { users in
            self.user = users
            print(users)
        }.store(in: &subscribers)
    }
    
    func getPost2(){
        combine.getPost(request: APIRouterStructure(apiRouter: .posts(userId: 10)).asURLRequest())
            .sink { result in
            switch result{
            case .failure(let error):
                print("Error ",error.localizedDescription)
            default:
                print("Completed")
            }
        } receiveValue: { posts in
            print(posts)
        }.store(in: &subscribers)
    }
    
    func getPost(){
        combine.getPost()//request: APIRouterStructure(apiRouter: .post(userId: 10)).asURLRequest())
            .sink { result in
            switch result{
            case .failure(let error):
                print("Error ",error.localizedDescription)
            default:
                print("Completed")
            }
        } receiveValue: { posts in
            print(posts)
        }.store(in: &subscribers)
    }
    
    func getComment(){
        combine.getComment(request: APIRouterStructure(apiRouter: .comment(postId: 100)).asURLRequest())
            .sink { result in
            switch result{
            case .failure(let error):
                print("Error ",error.localizedDescription)
            default:
                print("Completed")
            }
        } receiveValue: { posts in
            print(posts)
        }.store(in: &subscribers)
    }
    
    
    ///Multiple API Call using combine
    func fetchingComments_WithCombine(){
        combine.getUser(request: APIRouterStructure(apiRouter: .users).asURLRequest()).flatMap { [weak self] user -> AnyPublisher<[Post], Error> in
            if let user = user.last, let self = self {
                print("User -->", user)
                return self.combine.getPost(request: APIRouterStructure(apiRouter: .posts(userId: user.id)).asURLRequest())
            }else{
                return Fail(error: APIError.userNotFound).eraseToAnyPublisher()
            }
        }.flatMap { [weak self] posts -> AnyPublisher<[Comment], Error> in
            if let post = posts.last, let self = self{
                print("Post -->", posts)
                return self.combine.getComment(request: APIRouterStructure(apiRouter: .comment(postId: post.id)).asURLRequest())
            }else{
                return Fail(error: APIError.postNotFound).eraseToAnyPublisher()
            }
        }.sink { result in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            default:
                print("Completed")
            }
        } receiveValue: { comments in
            self.comments = comments
            print("Comments -->", comments)
        }.store(in: &subscribers)

    }
}

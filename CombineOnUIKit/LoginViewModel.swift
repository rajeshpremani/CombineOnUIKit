//
//  LoginViewModel.swift
//  ExamOk
//
//  Created by Rajesh Kumar Sahil on 29/08/2021.
//

import Foundation
import Combine

class LoginViewModel: BaseViewModel {
    
    private (set) var user:[User]?
    @Published private (set) var comments:[Comment]?
    
    let combine = NetworkService_Combine()
    let awaitAsync = NetworkService_AwaitAsync()
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

//Await Async
extension LoginViewModel{
    func fetchingComments_WithAwaitAsync(){
        Task(priority: .background) {
            let usersResult = await awaitAsync.getUser(request: APIRouterStructure(apiRouter: .users).asURLRequest())
            guard case .success(let users) = usersResult, let user = users.first else {return}
            let postsResult = await awaitAsync.getPost(request: APIRouterStructure(apiRouter: .posts(userId: user.id)).asURLRequest())
            guard case .success(let posts) = postsResult, let post = posts.first else {return}
            let commentResult = await awaitAsync.getComment(request: APIRouterStructure(apiRouter: .comment(postId: post.id)).asURLRequest())
            guard case .success(let comments) = commentResult else {return}
            self.comments = comments
            //Update View on Main thread after getting data
            print(comments)
        }
    }
    
    func fetchingComments_WithAwaitAsyncGenricFunc(){
        Task(priority: .background) {
            let usersResult = await awaitAsync.genric(request: APIRouterStructure(apiRouter: .users).asURLRequest(), type: User.self)
            
            guard case .success(let users) = usersResult, let user = users.first else {return}
            let postsResult = await awaitAsync.genric(request: APIRouterStructure(apiRouter: .posts(userId: user.id)).asURLRequest(), type: Post.self)
            guard case .success(let posts) = postsResult, let post = posts.first else {return}
            let commentResult = await awaitAsync.genric(request: APIRouterStructure(apiRouter: .comment(postId: post.id)).asURLRequest(), type: Comment.self)
            guard case .success(let comments) = commentResult else {return}
            self.comments = comments
            //Update View on Main thread after getting data
            print(comments)
        }
    }
}

//Generic Combine
extension LoginViewModel{
    func fetchingComments_WithGenCom(){
        NetworkManager.shared.getData(endpoint: .details, type: User.self)
            .sink { completion in
                switch completion {
                case .failure(let error): print("Error: ", error.localizedDescription)
                case .finished: print("Finished")
                }
        } receiveValue: { users in
            print(users)
        }.store(in: &subscribers)

    }
}

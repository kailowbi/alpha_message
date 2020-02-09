//
//  RegisterOrLoginViewReactor.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import ReactorKit
import FirebaseAuth

class RegisterOrLoginViewReactor: Reactor {
        
    let authRepository: AuthRepository
    
    enum Action {
        case initialize
        case signInByTwitter(credential:String)
    }
    struct State {
       var logined : Bool
    }
    let initialState: State = State(
        logined: false
    )
    enum Mutation{
        case setLogined(logined:Bool)
    }
    
    init(authRepository:AuthRepository) {
        self.authRepository = authRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize:
//            self.authRepository.login()
            return Observable.empty()
        case .signInByTwitter(let credential):
            return self.authRepository.twitterLogin().flatMap { _ -> Observable<Mutation> in
                
                return Observable.just(.setLogined(logined: true))
           }
        }
        return Observable.empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> RegisterOrLoginViewReactor.State {
        var newState = state
        
        switch mutation {
        case .setLogined(let logined):
            newState.logined = logined
        }
        
        return newState
    }
    
}

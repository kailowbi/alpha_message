//
//  RegisterOrLoginViewReactor.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import ReactorKit

class RegisterOrLoginViewReactor: Reactor {
        
    let authRepository: AuthRepository
    
    enum Action {
        case initialize
        case signInByTwitter
    }
    struct State {
        var logined : Bool
        var loading : Bool
    }
    let initialState: State = State(
        logined: false,
        loading: false
    )
    enum Mutation{
        case setLogined(logined:Bool)
        case setLoading(_ loading:Bool)
    }
    
    init(authRepository:AuthRepository) {
        self.authRepository = authRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize:
            return Observable.empty()
        case .signInByTwitter:
            
            return Observable.concat(
                Observable.just(.setLoading(true)),
                self.authRepository.twitterLogin().flatMap { _ -> Observable<Mutation> in
                    return Observable.concat(
                        Observable.just(.setLogined(logined: true)),
                        Observable.just(.setLoading(false))
                    )
                }.catchError({ error in
                    return Observable.just(.setLoading(false))
                })
            )
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> RegisterOrLoginViewReactor.State {
        var newState = state
        
        switch mutation {
        case .setLogined(let logined):
            newState.logined = logined
        case .setLoading(let loading):
            newState.loading = loading
        }
        
        return newState
    }
    
}

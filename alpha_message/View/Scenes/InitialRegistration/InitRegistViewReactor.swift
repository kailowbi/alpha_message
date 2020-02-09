//
//  InitRegistViewReactor.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import ReactorKit

class InitRegistViewReactor: Reactor {
        
    let authRepository: AuthRepository
    
    enum Action {
        case initialize
    }
    struct State {
       var loginSkip : Bool
    }
    let initialState: State = State(
        loginSkip: false
    )
    enum Mutation{
        case setLoginSkip(_ skip:Bool)
    }
    
    init(authRepository:AuthRepository) {
        self.authRepository = authRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize:
            return self.authRepository.currentUser().flatMap { user -> Observable<Mutation> in
                return Observable.just(.setLoginSkip(true))
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoginSkip(let skip):
            newState.loginSkip = skip
        }
        
        return newState
    }
}

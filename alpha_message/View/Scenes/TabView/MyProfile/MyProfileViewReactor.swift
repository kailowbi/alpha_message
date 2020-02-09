//
//  MyProfileViewReactor.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import ReactorKit

class MyProfileViewReactor: Reactor {
        
    let authRepository: AuthRepository
    
    enum Action {
        case initialize
    }
    struct State {
       var user : User?
    }
    let initialState: State = State(
        user: nil
    )
    enum Mutation {
        case setUser(user:User?)
    }
    
    init(authRepository:AuthRepository) {
        self.authRepository = authRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize:
            return self.authRepository.currentUser().flatMap { user -> Observable<Mutation> in
                return Observable.just(.setUser(user: user))
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setUser(let user):
            newState.user = user
        }
        
        return newState
    }
}

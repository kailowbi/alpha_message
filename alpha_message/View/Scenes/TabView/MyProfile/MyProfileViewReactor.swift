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
        case logout
    }
    struct State {
        var user : User?
        var logouted : Bool
    }
    let initialState: State = State(
        user: nil,
        logouted: false
    )
    enum Mutation {
        case setUser(user:User?)
        case setLogouted(_ logouted:Bool)
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
        case .logout:
            return self.authRepository.logout().flatMap { _ -> Observable<Mutation> in
                return Observable.just(.setLogouted(true))
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setUser(let user):
            newState.user = user
        case .setLogouted(let logouted):
            newState.logouted = logouted
        }
        
        return newState
    }
}

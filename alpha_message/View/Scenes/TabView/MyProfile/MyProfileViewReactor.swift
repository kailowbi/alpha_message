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
       var i : Int
    }
    let initialState: State = State(
        i: 0
    )
    
    init(authRepository:AuthRepository) {
        self.authRepository = authRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize:
//            self.authRepository.login()
            return Observable.empty()
        }
        return Observable.empty()
    }
    
    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        
        
        return  newState
    }
}

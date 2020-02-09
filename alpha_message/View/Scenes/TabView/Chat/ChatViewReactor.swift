//
//  ChatViewReactor.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import ReactorKit

class ChatViewReactor: Reactor {
        
    
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
    
    init() {
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize:
            return Observable.empty()
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

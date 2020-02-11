//
//  InRoomViewReactor.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import ReactorKit

class InRoomViewReactor: Reactor {

    let messageDataRepository:MessageDataRepository
    
    enum Action {
        case initialize(roomName:String)
    }
    struct State {
        var roomName: String
        var rooms : [Room]
        var roomCreated : Bool
    }
    let initialState: State = State(
        roomName: "",
        rooms: [],
        roomCreated: false
    )
    enum Mutation {
        case initialize
        case setRoomName(_ roomName:String)
    }
    
    init(messageDataRepository:MessageDataRepository) {
        self.messageDataRepository = messageDataRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize(let roomName):
            
            return Observable.just(.setRoomName(roomName))
            
            
            //return self.messageDataRepository.
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .initialize:
            newState = initialState
        case .setRoomName(let name):
            newState.roomName = name
     
        }
        
        return newState
    }
}

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
        case initialize
        case createRoom(roomName:String)
    }
    struct State {
        var rooms : [Room]
        var roomCreated : Bool
    }
    let initialState: State = State(
        rooms: [],
        roomCreated: false
    )
    enum Mutation {
        case initialize
        case setRooms(rooms:[Room])
        case setRoomCreated(_ created:Bool)
    }
    
    init(messageDataRepository:MessageDataRepository) {
        self.messageDataRepository = messageDataRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize:
            
            return Observable.concat(
                Observable.just(.initialize),
                self.messageDataRepository.getTest().flatMap { rooms -> Observable<Mutation> in
                    return Observable.just(.setRooms(rooms: rooms))
                }
            )
        case .createRoom(let roomName):
            return self.messageDataRepository.checkAndCreate(roomName:roomName).flatMap { _ -> Observable<Mutation> in
                return Observable.concat(
                    Observable.just(.setRoomCreated(true)),
                    Observable.just(.setRoomCreated(false))
                )
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .initialize:
            newState = initialState
        case .setRooms(let rooms):
            newState.rooms = rooms
        case .setRoomCreated(let created):
            newState.roomCreated = created
        }
        
        return newState
    }
}

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
        case setLisner
        case createMessage(message:String?)
        case setInputMessage(message:String)
    }
    struct State {
        var initialized:Bool
        var roomName: String
        var messages : [Message]
        var roomCreated : Bool
        var inputMessage: String
    }
    let initialState: State = State(
        initialized: false,
        roomName: "",
        messages: [],
        roomCreated: false,
        inputMessage: ""
    )
    enum Mutation {
        case initialize
        case setMessages(_ messages:[Message])
        case setRoomName(_ roomName:String)
        case setInputMessage(_ message:String)
    }
    
    init(messageDataRepository:MessageDataRepository) {
        self.messageDataRepository = messageDataRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize(let roomName):
            return Observable.just(.setRoomName(roomName))
            
        case .setLisner:
            return self.messageDataRepository.attachmentMessageListener(roomName: self.currentState.roomName) { callback -> Observable<Mutation> in
                
                return Observable.just(.setMessages(callback))
            }
            
        case .setInputMessage(let message):
            return Observable.just(.setInputMessage(message))
            
        case .createMessage(let m):
            if let message = m {
                return self.messageDataRepository.createMessage(roomName: self.currentState.roomName, message: message)
                    .flatMap{ _ -> Observable<Mutation> in
                        return Observable.just(.setInputMessage(""))
                }
            }else{
                return Observable.empty()
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .initialize:
            newState = initialState
        case .setRoomName(let name):
            newState.roomName = name
        case .setInputMessage(let message):
            newState.inputMessage = message
        case .setMessages(let messages):
            newState.messages = messages
        }
        
        return newState
    }
}

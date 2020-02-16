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
    let authRepository:AuthRepository

    enum Action {
        case initialize(roomName:String)
        case createMessage(message:String?)
        case setInputMessage(message:String?)
    }
    struct State {
        var initialized:Bool
        var roomName: String
        var messages : [Message]
        var roomCreated : Bool
        var inputMessage: String?
    }
    let initialState: State = State(
        initialized: false,
        roomName: "",
        messages: [],
        roomCreated: false,
        inputMessage: nil
    )
    enum Mutation {
        case initialize
        case setMessages(_ messages:[Message])
        case setRoomName(_ roomName:String)
        case setInputMessage(_ message:String?)
    }
    
    init(messageDataRepository:MessageDataRepository, authRepository:AuthRepository) {
        self.messageDataRepository = messageDataRepository
        self.authRepository = authRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialize(let roomName):
            
            return self.authRepository.currentUser().flatMap { user -> Observable<Mutation> in
                return Observable.concat(
                    Observable.just(.setRoomName(roomName)),
                    self.messageDataRepository.attachmentMessageListener(roomName: roomName) { messages -> Observable<Mutation> in
                        
                        var outMessage:[Message] = []
                        for message in messages {
                            let other = (user.id != message.from) ? true : false
                            outMessage.append(Message(message: message.message, from: message.from, isOther: other ))
                        }
                        
                        return Observable.just(.setMessages(outMessage))
                    }
                )
            }
            
        case .setInputMessage(let message):
            return Observable.just(.setInputMessage(message))
            
        case .createMessage(let m):
            
            return self.authRepository.currentUser().flatMap { user -> Observable<Mutation> in
                guard let message = m else { return Observable.empty() }
                if message == "" { return Observable.empty() }
                let messageData = Message(message: message, /*date: Date(),*/ from: user.id, isOther: nil)
                
                return self.messageDataRepository.createMessage(roomName: self.currentState.roomName, message: messageData)
                    .flatMap{ _ -> Observable<Mutation> in
                        return Observable.just(.setInputMessage(nil))
                }
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

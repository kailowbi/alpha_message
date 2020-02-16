//
//  MessageDataRepository.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift

protocol MessageDataRepository {
    func getMessagesFromRoom(roomName:String) -> Observable<Void>
    
    func getRooms() -> Observable<[Room]>
    func checkAndCreate(roomName:String) -> Observable<Void>
    
    func createMessage(roomName:String, message:Message) -> Observable<Void>
    
    func attachmentMessageListener<T>(roomName:String, _ callback: @escaping ([Message]) -> Observable<T>) -> Observable<T>
}

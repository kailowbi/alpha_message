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
    
    func getTest() -> Observable<[Room]>
    func checkAndCreate(roomName:String) -> Observable<Void>
}

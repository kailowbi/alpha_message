//
//  MessageDataRepository.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import FirebaseFirestore
import RxFirebase
import CodableFirebase

class MessageDataRepositoryOnFirebase: MessageDataRepository {
    
    private let firestore: Firestore
    
    private struct Collection {
        static let chats = "chats"
        static let chatsRooms = "chats_rooms"
    }
    private struct Document {
        static let messageByRoom = "message_by_room"
        static let iOS = "iOS"
        static let service = "service_status"
    }
    private struct Field {
        static let noticeUnreadCount = "notice_unread_count"
        static let minVersion = "min_version"
        static let isMaintenance = "is_maintenance"
        static let maintenanceDescription = "maintenance_description"
    }
    
    init(firestore:Firestore) {
        self.firestore = firestore
    }
    
    func getMessagesFromRoom(roomName: String) -> Observable<Void> {
        return Observable.empty()
    }
    
//    func createUnreadCollection<T>(_ callback: @escaping () -> Observable<T>) -> Observable<T> {
//        guard let uid = self.firebaseAuth.currentUser?.uid else { return Observable.empty() }
//        return self.firestore.collection(Collection.unread).document(uid).rx.existsInFirestore().flatMap { exists in
//            return exists ? callback() : self.createUnreadDocument(uid).flatMap{ callback() }
//        }
//    }

    func checkAndCreate(roomName:String) -> Observable<Void> {
        let ref = self.firestore.collection(Collection.chatsRooms).document(roomName)
        
        return Observable.merge(
            ref.rx
                .existsInFirestore()
                .flatMap { [unowned self] exist -> Observable<Void> in
                    let model = Room(name:"", date:nil)
                    return exist ? Observable.just(()) : self.createDocuments(ref, setData: model)
            },
            createMessageCollection(roomName: roomName)
        )
        
        
    }
    
    private func createMessageCollection(roomName:String) -> Observable<Void> {
        let ref = self.firestore.collection(Collection.chats).document(Document.messageByRoom)//.collection(roomName)
        return ref
            .rx
            .existsInFirestore()
            .flatMap { [unowned self] exist -> Observable<Void> in
                let model = Room(name:"", date:nil)
                return exist ? Observable.just(()) : self.createDocuments(ref, setData: model )
        }
    }
    
    
    private func createDocuments<T: Encodable>(_ ref: DocumentReference, setData:T) -> Observable<Void> {
        if let docData = try? FirestoreEncoder().encode(setData) {
            return ref.rx.setData(docData)
        }else{
            return Observable.error(NSError())
        }
    }
    
    
    func getRooms() -> Observable<[Room]> {
        return self.firestore.collection(Collection.chatsRooms)
             .rx
             .getDocuments()
             .flatMap { docs -> Observable<[Room]> in
                var rooms:[Room] = []
                for doc in docs.documents {
                    let room = Room(name: doc.documentID, date: nil)
                    rooms.append(room)
                }
                return Observable.just(rooms)
         }
     }
    
    func createMessage(roomName:String, message:Message) -> Observable<Void> {
                
        return self.firestore.collection(Collection.chats).document(Document.messageByRoom).collection(roomName)
            .rx
            .getDocuments()
            .flatMap { docs -> Observable<Void> in
                

                let docName = "m\(String(format: "%05d", docs.count+1))"
                let ref = self.firestore.collection(Collection.chats).document(Document.messageByRoom).collection(roomName).document(docName)
                return ref.rx
                    .existsInFirestore()
                    .flatMap { [unowned self] exist -> Observable<Void> in
                        
                        return exist ? Observable.just(()) : self.createDocuments(ref, setData: message)
                }
        }
        
    }

    func attachmentMessageListener<T>(roomName:String, _ callback: @escaping ([Message]) -> Observable<T>) -> Observable<T> {
        let ref = self.firestore.collection(Collection.chats).document(Document.messageByRoom).collection(roomName)
        return ref
            .rx
            .listen()
            .flatMap { colection -> Observable<T> in
                var messages:[Message] = []
                for document in colection.documents {
                    if let docData = try? FirestoreDecoder().decode(Message.self, from: document.data()) {
                        messages.append(docData)
                    }
                }
                
                return callback(messages)
        }
    }
    
}

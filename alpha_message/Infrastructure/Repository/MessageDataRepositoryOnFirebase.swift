//
//  MessageDataRepository.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import FirebaseFirestore
//import CodableFirebase
import RxFirebase
import FirebaseAuth
import CodableFirebase

class MessageDataRepositoryOnFirebase: MessageDataRepository {
    
    private let firebaseAuth:Auth
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
    
    init(firestore:Firestore, firebaseAuth:Auth) {
        self.firestore = firestore
        self.firebaseAuth = firebaseAuth
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
                    return exist ? Observable.just(()) : self.createDocuments(ref)
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
                
                return exist ? Observable.just(()) : self.createDocuments(ref)
        }
    }
    
    
    private func createDocuments(_ ref: DocumentReference) -> Observable<Void> {
        let model = Room(name:"", date:nil)
        if let docData = try? FirestoreEncoder().encode(model) {
            return ref.rx.setData(docData)
        }else{
            return Observable.error(NSError())
        }
    }
    
    
    func getTest() -> Observable<[Room]> {
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
 
    
//    return self.firestore.collection(Collection.chats).document(Document.rooms)
//                .rx
//                .getDocuments()
//                .flatMap { docs -> Observable<Bool> in
//
//                   for document in docs.documents {
//                       let docId = document.documentID
//                       let message = document.data()["message"]
//
//                       print(1)
//                   }
//
    
}

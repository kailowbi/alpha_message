//
//  FireStore+Rx.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/11.
//  Copyright © 2020 seiha i. All rights reserved.
//

import RxSwift
import FirebaseFirestore

extension Reactive where Base: DocumentReference {
    public func existsInFirestore() -> Observable<Bool> {
        return Observable.create { observer in
            self.base.getDocument { snapshot, error in
                    if let error = error {
                        observer.onError(error)
                    } else if let snapshot = snapshot, snapshot.exists {
                        observer.onNext(true)
                        observer.onCompleted()
                    } else {
                        observer.onNext(false)
                        observer.onCompleted()
                    }
            }
            return Disposables.create()
        }
    }
}

extension Reactive where Base: CollectionReference {
    public func existsInFirestore() -> Observable<Bool> {
        return Observable.create { observer in
            let ff = self.base.collectionID
            
            observer.onNext(true)
            observer.onCompleted()
            
//            if let collectionID = self.base.collectionID {
//                observer.onNext(true)
//                observer.onCompleted()
//            } else {
//                observer.onNext(false)
//                observer.onCompleted()
//            }
            return Disposables.create()
        }
    }
}

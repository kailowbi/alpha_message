//
//  AuthRepositoryOnFirebase.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

class AuthRepositoryOnFirebase : AuthRepository {
    
    private let firebaseAuth:Auth
    
    init(auth:Auth) {
        self.firebaseAuth = auth
    }
    
    func registor() -> Observable<Void> {
        return Observable.empty()
    }
    
    func twitterLogin(token:String) -> Observable<Void> {
        
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        
            
        return  Observable.empty()
        
//        if self.firebaseAuth.currentUser != nil{
//            return self.firebaseAuth.currentUser!.rx.linkAndRetrieveData(with: credential).flatMap { authDataResult -> Observable<Bool> in
//                return Observable.just( true )
//            }.catchError { error -> Observable<Bool> in
//                let e = error as NSError
//                if e.code == AuthErrorCode.providerAlreadyLinked.rawValue {
//                    return self.SocialSignInAndRetrieveData(credential: credential)
//                }else{
//                    return self.SocialSignInAndRetrieveData(credential: credential)
//                }
//            }
//        }else{
//            return self.SocialSignInAndRetrieveData(credential: credential)
//        }
            
   
    }
    
    
}

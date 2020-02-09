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
import RxFirebase

class AuthRepositoryOnFirebase : AuthRepository {
    
    private let firebaseAuth:Auth
    var provider = OAuthProvider(providerID: "twitter.com")
    
    init(auth:Auth) {
        self.firebaseAuth = auth
    }
    
    func registor() -> Observable<Void> {
        return Observable.empty()
    }
    
    func twitterLogin() -> Observable<Void> {
        return Observable.create { [unowned self] observer in                        
            self.provider.getCredentialWith(nil) { [unowned self] (c, error) in
                if let erro = error {
                    // Handle error.
                    observer.onError(erro)
                    observer.onCompleted()
                }else{
                    guard let credential = c else {
                        observer.onError(NSError())
                        observer.onCompleted()
                        return
                    }
                    
                    self.firebaseAuth.signIn(with: credential) { (result, error) in
                        if let erro = error {
                            // Handle error.
                            observer.onError(erro)
                            observer.onCompleted()
                        }else{
                            observer.onNext(())
                            observer.onCompleted()
                        }
                    }
                }
            }
            
            
            return Disposables.create {}
        }
   
    }
    
    
}

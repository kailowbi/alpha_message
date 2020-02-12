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
    
    init(firebaseAuth:Auth) {
        self.firebaseAuth = firebaseAuth
    }
    
    func currentUser() -> Observable<User> {
        return Observable.create { [unowned self] observer in
            
            if let curretUser = self.firebaseAuth.currentUser {
                let user = User(id: curretUser.uid, name: nil)
                observer.onNext( user )
            }else{
                observer.onError(NSError())
            }
            observer.onCompleted()

            return Disposables.create {}
        }
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
    
    func logout() -> Observable<Void> {
        return Observable.create { [unowned self] observer in
            
            do {
                try self.firebaseAuth.signOut()
                observer.onNext(())
                observer.onCompleted()
            } catch let error as NSError {
                observer.onError(error)
                observer.onCompleted()
            }
            
            
            return Disposables.create {}
        }
        //return self.firebaseAuth.rx.signIn(
    }
    
}

//
//  AuthRepositoryOnFirebase.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import Foundation
import RxSwift

class AuthRepositoryOnFirebase : AuthRepository {
    func registor() -> Observable<Void> {
        return Observable.empty()
    }
    
    func login() -> Observable<Void> {
        return Observable.empty()
    }    
}

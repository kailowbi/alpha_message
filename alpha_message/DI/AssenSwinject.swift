//
//  Swinject.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import Swinject

import FirebaseAuth

//class AssenSwinject {
//    let container = Container()
////    container.register(AuthRepository.self) { r in
////        r.resolve(AuthRepositoryOnFirebase.self)
////    }
//
//}

extension Container {
    
    static var shared:Container{
        let container = Container()
        let assembler = Assembler(container: container)
        
        assembler.apply(assemblies: [
            ViewAssembly(),
            ReactorAssembly(),
            RepositoryAssembly(),
            ThirdpartyAssembly()
        ])
        
        return container
    }
}

extension Container {
    class ViewAssembly: Assembly {
        func assemble(container: Container) {
            container.register(InitRegistViewController.self) { r in
                return InitRegistViewController()
            }
            container.register(RegisterOrLoginViewController.self) { r in
                let vc = RegisterOrLoginViewController()
                vc.reactor = r.resolve(RegisterOrLoginViewReactor.self)!
                return vc
            }
        }
    }
    
    class ReactorAssembly: Assembly {
        func assemble(container: Container) {
            container.register(InitRegistViewReactor.self) { r in
                return InitRegistViewReactor(authRepository: r.resolve(AuthRepository.self)!)
            }
            container.register(RegisterOrLoginViewReactor.self) { r in
                return RegisterOrLoginViewReactor(authRepository: r.resolve(AuthRepository.self)!)
            }
        }
    }
    
    class RepositoryAssembly: Assembly {
        func assemble(container: Container) {
            container.register(AuthRepository.self) { r in
                return AuthRepositoryOnFirebase(auth: r.resolve(Auth.self)! )
            }
        }
    }
    
    class ThirdpartyAssembly: Assembly {
        func assemble(container: Container) {
            container.register(Auth.self) { r in
                return Auth.auth()
            }
        }
    }
}

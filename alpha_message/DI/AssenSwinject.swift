//
//  Swinject.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import Swinject

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
            RepositoryAssembly()
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
        }
    }
    
    class ReactorAssembly: Assembly {
        func assemble(container: Container) {
            container.register(InitRegistViewReactor.self) { r in
                return InitRegistViewReactor(authRepository: r.resolve(AuthRepository.self)!)
            }
        }
    }
    
    class RepositoryAssembly: Assembly {
        func assemble(container: Container) {
            container.register(AuthRepository.self) { r in
                return AuthRepositoryOnFirebase()
            }
        }
        
    }
}

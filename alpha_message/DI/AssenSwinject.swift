//
//  Swinject.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import Swinject
import FirebaseAuth
import FirebaseFirestore

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
                let vc = InitRegistViewController()
                vc.reactor = r.resolve(InitRegistViewReactor.self)!
                return vc
            }
            container.register(RegisterOrLoginViewController.self) { r in
                let vc = RegisterOrLoginViewController()
                vc.reactor = r.resolve(RegisterOrLoginViewReactor.self)!
                return vc
            }
            container.register(TabViewController.self) { r in
                return TabViewController(
                    chatViewViewController: r.resolve(UINavigationController.self, name: NSStringFromClass(ChatViewViewController.self))!,
                    myPageViewController: r.resolve(MyProfileViewController.self)!
                )
            }
            container.register(UINavigationController.self, name: NSStringFromClass(ChatViewViewController.self)) { r in
                let nc = UINavigationController()
                let vc = ChatViewViewController()
                nc.setViewControllers([vc], animated: false)
                vc.reactor = r.resolve(ChatViewReactor.self)!
                return nc
            }
            container.register(InRoomViewViewController.self) { (r, roomName:String) in
                let vc = InRoomViewViewController(roomName: roomName)
                vc.reactor = r.resolve(InRoomViewReactor.self)!
                return vc
            }
            container.register(MyProfileViewController.self) { r in
                let vc = MyProfileViewController()
                vc.reactor = r.resolve(MyProfileViewReactor.self)!
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
            container.register(ChatViewReactor.self) { r in
                return ChatViewReactor(messageDataRepository: r.resolve(MessageDataRepository.self)!)
            }
            container.register(InRoomViewReactor.self) { r in
                return InRoomViewReactor(
                    messageDataRepository: r.resolve(MessageDataRepository.self)!,
                    authRepository: r.resolve(AuthRepository.self)!
                )
            }
            container.register(MyProfileViewReactor.self) { r in
                return MyProfileViewReactor(authRepository: r.resolve(AuthRepository.self)!)
            }
        }
    }
    
    class RepositoryAssembly: Assembly {
        func assemble(container: Container) {
            container.register(AuthRepository.self) { r in
                return AuthRepositoryOnFirebase(firebaseAuth: r.resolve(Auth.self)! )
            }
            
            container.register(MessageDataRepository.self) { r in
                return MessageDataRepositoryOnFirebase(firestore: r.resolve(Firestore.self)!, firebaseAuth: r.resolve(Auth.self)!)
            }
            
        }
    }
    
    class ThirdpartyAssembly: Assembly {
        func assemble(container: Container) {
            container.register(Auth.self) { r in
                return Auth.auth()
            }
            container.register(Firestore.self) { r in
                return Firestore.firestore()
            }
        }
    }
}

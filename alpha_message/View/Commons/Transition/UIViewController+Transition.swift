//
//  UIViewController+Transition.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/10.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import Swinject

protocol TransitionViewController {
    func transitionMain()
    func transitionInit()
}
extension TransitionViewController {
    func transitionMain () {
        if let window = SceneDelegate.shared?.window{
            // A mask of options indicating how you want to perform the animations.
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            
            SceneDelegate.shared?.window?.rootViewController = Container.shared.resolve(TabViewController.self)!
            
            UIView.transition(with: window, duration: 0.5, options: options, animations: {}, completion:nil)
        }
    }
    
    func transitionInit () {
        if let window = SceneDelegate.shared?.window{
            // A mask of options indicating how you want to perform the animations.
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            
            SceneDelegate.shared?.window?.rootViewController = Container.shared.resolve(InitRegistViewController.self)!
            
            UIView.transition(with: window, duration: 0.5, options: options, animations: {}, completion:nil)
        }
    }
}


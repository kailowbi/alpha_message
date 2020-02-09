//
//  RegisterOrLoginViewController.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import SVGKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class RegisterOrLoginViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    let titles = UIImageView(image: SVGKImage(contentsOf: R.file.titleSvg() ).uiImage )
    let twitterButton = UIButton().then{
        $0.setImage(SVGKImage(contentsOf: R.file.twitterSvg()).uiImage, for: .normal)
    }
    var provider = OAuthProvider(providerID: "twitter.com")


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(titles)
        self.view.addSubview(twitterButton)
        
        titles.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        twitterButton.snp.makeConstraints { make in
            make.top.equalTo(titles.snp.bottom).offset(32)
            make.left.equalTo(titles.snp.left)
        }
        
        
       
        
      
    }
    

    func twiiterLogin(){
        provider.getCredentialWith(nil) { credential, error in
            if error != nil {
                // Handle error.
                print(11)
            }
            
            
            if let credential = credential {
               
            }
        }

    }
    
    func facebookLoginOnWebview(completion: ( (_ token:String?, _ error:Error?) -> ())? = nil ) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: ["public_profile", "email", "user_friends",], from: self) { [unowned self] (result, error) in
//            self.reactor?.action.onNext(.setLoading(isLoading:true))

            if (error == nil){
                if let token = result?.token {
                    completion?(token.tokenString, nil)
                    return
                }else{
                    completion?(nil, nil)
                }
            }else{
                print(error!.localizedDescription)
                completion?(nil, error)
            }
        }
    }
   

}

extension RegisterOrLoginViewController : View {
    func bind(reactor: RegisterOrLoginViewReactor) {
     
        twitterButton.rx.tap.map{
            return Reactor.Action.signInByTwitter(credential: "ssss")
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.logined }
            .distinctUntilChanged()
            .filter{ $0 == true }
            .subscribe(onNext: { [unowned self] logined in
                print(11)
              
                // override RootViewContrroller
//                if let windowScene = scene as? UIWindowScene {
//                    let window = UIWindow(windowScene: windowScene)
//                    window.rootViewController = Container.shared.resolve(TabViewController.self)!
//                    self.window = window
//                    window.makeKeyAndVisible()
//                }
                
//                guard let window = UIApplication.shared.keyWindow else { return }
//                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                if window.rootViewController?.presentedViewController != nil {
//                    // モーダルを開いていたら閉じてから差し替え
//                    window.rootViewController?.dismiss(animated: false) {
//                        window.rootViewController = storyboard.instantiateInitialViewController()
//                    }
//                } else {
//                    // モーダルを開いていなければそのまま差し替え
//                    window.rootViewController = storyboard.instantiateInitialViewController()
//                }
                
            }).disposed(by: self.disposeBag)
    }
}

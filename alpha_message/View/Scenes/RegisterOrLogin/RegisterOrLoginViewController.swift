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
import SnapKit
import Then
import SVGKit
import FirebaseAuth

class RegisterOrLoginViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let titles = UIImageView(image: SVGKImage(contentsOf: R.file.titleSvg() ).uiImage )
    let twitterButton = UIButton().then{
        $0.setImage(SVGKImage(contentsOf: R.file.twitterSvg()).uiImage, for: .normal)
    }

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
        
        
        twitterButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.twiiterLogin()
        }).disposed(by: self.disposeBag)
        
      
    }
    
    func twiiterLogin(){
        let provider = OAuthProvider(providerID: "twitter.com")
        provider.getCredentialWith(nil) { credential, error in
            if error != nil {
                // Handle error.
                print(11)
            }
            
            if let credential = credential {
                Auth.auth().signIn(with: credential) { authResult, error in
                    if error != nil {
                        // Handle error.
                    }
                    // User is signed in.
                    // IdP data available in authResult.additionalUserInfo.profile.
                    // Twitter OAuth access token can also be retrieved by:
                    // authResult.credential.accessToken
                    // Twitter OAuth ID token can be retrieved by calling:
                    // authResult.credential.idToken
                    // Twitter OAuth secret can be retrieved by calling:
                    // authResult.credential.secret
                    
                    
                    
                }
            }
        }

    }
   

}


//
//  MyProfileViewController.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import ReactorKit
import SnapKit
import Then
import SVGKit
import Swinject

class MyProfileViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let name = UILabel().then{
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: .comfortaaRegular, size: 36)
        $0.text = "Not Log in."
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
    }
    let logoutButton = UIButton().then{
        $0.setImage(SVGKImage(contentsOf: R.file.logoutSvg()).uiImage, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(name)
        self.view.addSubview(logoutButton)
        
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(192)
            make.left.right.equalToSuperview().inset(16)
        }
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
        }
        
    }
    
}

extension MyProfileViewController : View, TransitionViewController {
    func bind(reactor: MyProfileViewReactor) {
        
        self.rx.viewWillAppear.map{ _ in
            return Reactor.Action.initialize
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        self.logoutButton.rx.tap.map{
            Reactor.Action.logout
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        
        reactor.state.map { $0.user }
            .distinctUntilChanged()
            .filter{ $0 != nil }
            .subscribe(onNext: { [unowned self] user in
                self.name.text = user?.id
            }).disposed(by: self.disposeBag)
        
        reactor.state.map { $0.logouted }
            .distinctUntilChanged()
            .filter{ $0 == true }
            .subscribe(onNext: { [unowned self] logouted in
                self.transitionInit()
            }).disposed(by: self.disposeBag)
        
        
        
    }
}



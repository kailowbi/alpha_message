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
import Swinject

class RegisterOrLoginViewController: UIViewController, UIViewControllerJoinLoading {
    var activityIndicatorBaseView: UIView?
    
    var disposeBag = DisposeBag()
    
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
    }
}

extension RegisterOrLoginViewController : View, TransitionViewController {
    func bind(reactor: RegisterOrLoginViewReactor) {
     
        twitterButton.rx.tap.map{
            return Reactor.Action.signInByTwitter
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.loading }
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] loading in
                if loading {
                    self.startLoading()
                }else{
                    self.stopLoading()
                }
            }).disposed(by: self.disposeBag)
        
        reactor.state.map { $0.logined }
            .distinctUntilChanged()
            .filter{ $0 == true }
            .subscribe(onNext: { [unowned self] logined in
                
                self.dismiss(animated: true) {
                    self.transitionMain()
                }

            }).disposed(by: self.disposeBag)
    }
}

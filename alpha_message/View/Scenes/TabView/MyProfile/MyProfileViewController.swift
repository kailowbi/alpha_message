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
import ReactorKit
import SnapKit
import Then
import SVGKit
import Swinject

class MyProfileViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    var name = UILabel().then{
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: .comfortaaRegular, size: 36)
        $0.text = "Not Log in."
        $0.textAlignment = .center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        

        
        self.view.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(192)
            make.left.right.equalToSuperview().inset(16)
        }
        
    }
    
}

extension MyProfileViewController : View {
    func bind(reactor: MyProfileViewReactor) {
        
    }
}



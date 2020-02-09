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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        
    }
    
}

extension MyProfileViewController : View {
    func bind(reactor: MyProfileViewReactor) {
        
    }
}



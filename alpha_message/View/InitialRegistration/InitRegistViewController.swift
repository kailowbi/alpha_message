//
//  ViewController.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import SnapKit

class InitRegistViewController: UIViewController {

    let bgView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemYellow
        bgView.backgroundColor = .red
        
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.displayAlert(title: "aaa", message: "aaa", style: .alert, btns: [BtnType(title: "aaa")], completion: nil)
    }


}


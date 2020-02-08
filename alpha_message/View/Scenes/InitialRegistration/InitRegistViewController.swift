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
    
//    let image0 =

//    let layer0 = CALayer()

//    layer0.contents = image0
//
//    layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 2.83, b: 0, c: 0, d: 1, tx: -0.91, ty: 0))
//
//    layer0.bounds = view.bounds
//
//    layer0.position = view.center
//
//    view.layer.addSublayer(layer0)


    
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


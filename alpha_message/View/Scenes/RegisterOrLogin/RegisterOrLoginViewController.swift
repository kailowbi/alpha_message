//
//  RegisterOrLoginViewController.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import SnapKit
import Then
import SVGKit

class RegisterOrLoginViewController: UIViewController {

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
            make.left.equalTo(titles.snp.left)
            make.top.equalTo(titles.snp.bottom)
        }
        
        
        
      
    }
   

}


//
//  ViewController.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/08.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import SnapKit
import Then
import SVGKit

class InitRegistViewController: UIViewController {

//    let bgView = UIView()
    let mainImageLogo = UIImageView(image: SVGKImage(contentsOf: R.file.logoSvg() ).uiImage )
    let mainImageView = UIImageView().then {
        $0.image = R.image.rectangleJpg()
    }
    let buttonArea = UIView().then{
        $0.backgroundColor = .white
    }
    let safeAreaDammy = UIView().then{
        $0.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(mainImageView)
        self.mainImageView.addSubview(mainImageLogo)
        self.view.addSubview(buttonArea)
        self.view.addSubview(safeAreaDammy)

        mainImageView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalTo(buttonArea.snp.top)
        }
        mainImageLogo.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        buttonArea.snp.makeConstraints { make in
            make.height.equalTo(71)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        safeAreaDammy.snp.makeConstraints { make in
            make.top.equalTo(buttonArea.snp.bottom)
            make.right.bottom.left.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.displayAlert(title: "aaa", message: "aaa", style: .alert, btns: [BtnType(title: "aaa")], completion: nil)
    }


}


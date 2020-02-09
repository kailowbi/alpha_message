//
//  InitRegistViewController.swift
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
import Swinject

class InitRegistViewController: UIViewController {

    let disposeBag = DisposeBag()
    
//    let bgView = UIView()
    let mainImageLogo = UIImageView(image: SVGKImage(contentsOf: R.file.logoSvg() ).uiImage )
    let mainImageView = UIImageView().then {
        $0.image = R.image.rectangleJpg()
    }
    let buttonArea = UIView().then{
        $0.backgroundColor = .white
    }
    let loginButton = UIButton().then{
        $0.setImage(SVGKImage(contentsOf: R.file.loginSvg() ).uiImage, for: .normal)
        $0.backgroundColor = .yellow
    }
    let registerButton = UIButton().then{
        $0.setImage(SVGKImage(contentsOf: R.file.registerSvg() ).uiImage, for: .normal)
        $0.backgroundColor = .red
    }
    let safeAreaDammy = UIView().then{
        $0.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(mainImageView)
        self.mainImageView.addSubview(mainImageLogo)
        self.view.addSubview(buttonArea)
        self.buttonArea.addSubview(loginButton)
        self.buttonArea.addSubview(registerButton)
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
        loginButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(registerButton.snp.left)
        }
        registerButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
//            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
        }
        safeAreaDammy.snp.makeConstraints { make in
            make.top.equalTo(buttonArea.snp.bottom)
            make.right.bottom.left.equalToSuperview()
        }
        
        registerButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.present( Container.shared.resolve(RegisterOrLoginViewController.self)!, animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
    }
    

}



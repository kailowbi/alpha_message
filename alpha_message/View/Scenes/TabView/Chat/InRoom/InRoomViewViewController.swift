//
//  InRoomViewViewController.swift
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

class InRoomViewViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var roomName = String()
    
    let tableView = UITableView().then{
        $0.register(RoomsTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(RoomsTableViewCell.self))
        $0.rowHeight = 84
    }
    var textBox:UIView!
    let textField = PaddingTextField().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.init(hex: "E5E5EA").cgColor
    }
    let sendButton = UIButton().then{
        $0.setImage(SVGKImage(contentsOf: R.file.sendSvg()).uiImage, for: .normal)
    }
    
    
    init(roomName:String) {
        super.init(nibName: nil, bundle: nil)

        self.roomName = roomName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem().then { $0.title = nil }
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        textBox = UIView().then{
            $0.backgroundColor = UIColor.init(hex: "F9F9F9")
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.init(hex: "E5E5EA").cgColor
            $0.addSubview(self.textField)
            $0.addSubview(self.sendButton)
        }
        self.view.addSubview(textBox)
               
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.right.equalToSuperview().inset(56)
            make.bottom.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(16)
        }
        sendButton.snp.makeConstraints { make in
            make.left.equalTo(textField.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        textBox.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalTo(textBox.snp.top)
        }
        
        
    }
    
}

extension InRoomViewViewController : View {
    func bind(reactor: InRoomViewReactor) {
        
        self.rx.viewDidAppear.map{ _ in
            return Reactor.Action.initialize(roomName: self.roomName)
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.roomName }
            .distinctUntilChanged()
            .filter{ $0 != "" }.map{ _ in
                Reactor.Action.setLisner
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        
        self.textField.rx.controlEvent(.editingChanged).map { [unowned self] _ in
            return Reactor.Action.setInputMessage(message: self.textField.text ?? "" )
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        self.textField.rx.controlEvent(.editingDidEndOnExit).map { [unowned self] _ in
            return Reactor.Action.createMessage(message: self.textField.text)
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        self.sendButton.rx.tap.map{ [unowned self] _ in
            return Reactor.Action.createMessage(message: self.textField.text)
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.messages }
            .distinctUntilChanged()
            .bind(to: self.tableView.rx.items(cellIdentifier: NSStringFromClass(RoomsTableViewCell.self), cellType: RoomsTableViewCell.self)) { row, el, cell in
                cell.title.text = el.message
                cell.layoutIfNeeded()
            }
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.inputMessage }
            .distinctUntilChanged()
            .filter{ $0 != self.textField.text }
            .subscribe(onNext: { [unowned self] message in
                self.textField.text = message
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.inputMessage }
        .distinctUntilChanged()
        .filter{ $0 == "" }
        .subscribe(onNext: { [unowned self] message in
            self.textField.resignFirstResponder()
        })
        .disposed(by: self.disposeBag)
       
    }
}



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
        $0.rowHeight = 100
    }
    let createButton = UIButton().then{
        $0.setImage(SVGKImage(contentsOf: R.file.createSvg()).uiImage, for: .normal)
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
        self.view.addSubview(createButton)
        
        tableView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        createButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(16)
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
        
        self.createButton.rx.tap.subscribe(onNext: { [unowned self] _ in
           print(1111)
        }).disposed(by: self.disposeBag)
        
        reactor.state.map { $0.rooms }
            .distinctUntilChanged()
            .bind(to: self.tableView.rx.items(cellIdentifier: NSStringFromClass(RoomsTableViewCell.self), cellType: RoomsTableViewCell.self)) { row, el, cell in
                cell.title.text = el.name
                cell.layoutIfNeeded()
            }
            .disposed(by: self.disposeBag)
 
       
        
    }
}



//
//  ChatViewViewController.swift
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

class ChatViewViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let tableView = UITableView().then{
        $0.register(RoomsTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(RoomsTableViewCell.self))
        $0.rowHeight = 100
    }
    let createButton = UIButton().then{
        $0.setImage(SVGKImage(contentsOf: R.file.createSvg()).uiImage, for: .normal)
    }
    let refreshController = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        self.view.addSubview(createButton)
        tableView.refreshControl = refreshController
        
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

extension ChatViewViewController : View {
    func bind(reactor: ChatViewReactor) {
        
        self.rx.viewDidAppear.map{ _ in
            return Reactor.Action.initialize
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        self.refreshController.rx.controlEvent(.valueChanged).map{ _ in
            return Reactor.Action.initialize
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
            
        self.createButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.displayAlertWithTextField(title: "Create Room", message: "Please enter an existing or new room name.", style: .alert, btns: [BtnType(title: "キャンセル"), BtnType(title: "OK")]) { index,outText in
                switch index {
                case 1:
                    if let text = outText{
                        
                        reactor.action.onNext(.createRoom(roomName: text))
                    }
                default:
                    break
                }
            }
        }).disposed(by: self.disposeBag)
        
        self.tableView.rx.modelSelected(Room.self)
            .subscribe(onNext: { [unowned self] room in
                self.navigationController?.pushViewController(Container.shared.resolve(InRoomViewViewController.self, argument: room.name!)!, animated: true)
            }).disposed(by: self.disposeBag)
        
        reactor.state.map { $0.rooms }
            .distinctUntilChanged()
            .bind(to: self.tableView.rx.items(cellIdentifier: NSStringFromClass(RoomsTableViewCell.self), cellType: RoomsTableViewCell.self)) { row, el, cell in
                cell.roomName.text = el.name
                cell.layoutIfNeeded()
            }
            .disposed(by: self.disposeBag)
 
         reactor.state.map { $0.roomCreated }
         .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] _ in
                //reactor.action.onNext(.initialize)
            })
            .disposed(by: self.disposeBag)
        
    }
}



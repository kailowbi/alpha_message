//
//  MessageTableViewCell.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/11.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import SnapKit
import Then
import SVGKit

class MessageBox :UIView {
    var icon = UIImageView().then{
        $0.image = SVGKImage(contentsOf: R.file.my_profileSvg()).uiImage
        $0.layer.cornerRadius = 14
        $0.backgroundColor = .gray
    }
    var message = UITextView().then{
        $0.backgroundColor = UIColor.init(hex: "F7F7F7")
        $0.font = UIFont(name: .comfortaaRegular, size: 14)
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.addSubview(icon)
        self.addSubview(message)
        
    }
    
    
}

class MessageTableViewCell: UITableViewCell {

    var isOther = false
    
//    var boxForOwn = UIView()
//    var boxForOther = UIView()
//    var iconOwn = UIImageView().then{
//        $0.image = SVGKImage(contentsOf: R.file.my_profileSvg()).uiImage
//        $0.layer.cornerRadius = 14
//        $0.backgroundColor = .gray
//    }
//    var messageOwn = UILabel().then{
//        $0.backgroundColor = UIColor.init(hex: "F7F7F7")
//
//        $0.layer.cornerRadius = 6
//        $0.clipsToBounds = true
//    }
    
    var messageBoxOwn = MessageBox()
    var messageBoxOther = MessageBox()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(messageBoxOwn)
        self.addSubview(messageBoxOther)

        messageBoxOther.message.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        messageBoxOwn.message.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
        messageBoxOther.icon.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.height.equalTo(28)
        }
        messageBoxOther.message.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.left.equalTo(messageBoxOther.icon.snp.right).offset(16)
        }
        
        messageBoxOwn.icon.snp.makeConstraints { make in
            make.right.top.equalToSuperview()
            make.width.height.equalTo(28)
        }
        messageBoxOwn.message.snp.makeConstraints { make in
            make.right.equalTo(messageBoxOwn.icon.snp.left).inset(-16)
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
      
        
        messageBoxOther.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
        }
        messageBoxOwn.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
        }
    }
    
    func setMessage(msg:String) {
        messageBoxOther.message.text = msg
        messageBoxOwn.message.text = msg
    }
    
    func setOther(isOther:Bool) {
        if isOther {
            messageBoxOther.isHidden = false
            messageBoxOwn.isHidden = true
        }else{
            messageBoxOther.isHidden = true
            messageBoxOwn.isHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

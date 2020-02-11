//
//  RoomsTableViewCell.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/11.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import SnapKit
import Then

class RoomsTableViewCell: UITableViewCell {

    var box = UIView()
    var title = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(box)
        box.addSubview(title)
        box.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
        title.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview().inset(0)
            make.height.equalTo(18)
        }
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

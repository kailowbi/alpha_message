//
//  UIFont+Family.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/09.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit

extension UIFont {
    convenience init(name: FontNames, size: CGFloat) {
        self.init(name: name.rawValue, size: size)!
    }
}

public enum FontNames: String {
    case comfortaaRegular = "Comfortaa-Regular"
}

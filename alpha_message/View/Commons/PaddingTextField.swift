//
//  PaddingTextField.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/11.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
    var padding: CGPoint = CGPoint(x: 10.0, y: 0.0)
    
    // MARK: Internal Methods
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // テキストの内側に余白を設ける
        return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        // 入力中のテキストの内側に余白を設ける
        return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        // プレースホルダーの内側に余白を設ける
        return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
    }
}


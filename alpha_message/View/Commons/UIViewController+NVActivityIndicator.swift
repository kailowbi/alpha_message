//
//  UIViewController+NVActivityIndicator.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/09.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

protocol UIViewControllerJoinLoading:UIViewController {
    var activityIndicatorBaseView: UIView? { get set }
}

extension UIViewControllerJoinLoading {
    
    func startLoading (){
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect.zero, type: .ballClipRotatePulse, color: .black , padding: 0)
        activityIndicatorBaseView = UIView()
        
        guard let activityIndicatorBaseView = activityIndicatorBaseView else { return }
        
        activityIndicatorBaseView.addSubview(activityIndicatorView)
        self.view.addSubview(activityIndicatorBaseView)
        
        activityIndicatorView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        activityIndicatorBaseView.snp.makeConstraints { make in
            make.top.right.bottom.leading.equalToSuperview()
        }
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        
        if let activityIndicatorView = activityIndicatorBaseView?.subviews[0] as? NVActivityIndicatorView {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
            activityIndicatorBaseView?.removeFromSuperview()
        }
    }
}

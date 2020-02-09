//
//  TabViewController.swift
//  alpha_message
//
//  Created by aeaells on 2020/02/09.
//  Copyright © 2020 seiha i. All rights reserved.
//

import UIKit
import SVGKit

class TabViewController: UITabBarController,UITabBarControllerDelegate {

    let chatViewViewController: UIViewController
    let myProfileViewController: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        
        self.chatViewViewController.tabBarItem = UITabBarItem(title: nil, image: SVGKImage.customSVGKImage(contentsOf: R.file.commentSvg(), size: CGSize(width: 60, height: 60))!.uiImage , selectedImage: SVGKImage.customSVGKImage(contentsOf: R.file.comment_onSvg(), size: CGSize(width: 60, height: 60))!.uiImage )
        
        self.myProfileViewController.tabBarItem = UITabBarItem(title: nil, image: SVGKImage.customSVGKImage(contentsOf: R.file.my_profileSvg(), size: CGSize(width: 60, height: 60))!.uiImage , selectedImage: SVGKImage.customSVGKImage(contentsOf: R.file.my_profile_onSvg(), size: CGSize(width: 60, height: 60))!.uiImage )
        self.setViewControllers( [self.chatViewViewController, self.myProfileViewController], animated: true )
        
        self.tabBar.tintColor = UIColor(hex: "FF4D00")
        self.tabBar.barTintColor = .white
    }
    
    init(chatViewViewController:UIViewController, myPageViewController: UIViewController) {
        self.chatViewViewController = chatViewViewController
        self.myProfileViewController = myPageViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

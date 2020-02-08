
//
//  UIViewController+Animation.swift
//  brahms-ios
//
//  Created by aeaells on 2018/08/20.
//  Copyright © 2018年 seiha i. All rights reserved.
//

import Foundation
import UIKit

//メッセージ一覧
extension UIViewController{
    
    struct BtnType {
        let title:String
        var style:UIAlertAction.Style?
        
        init(title:String) {
            self.title = title
            self.style = nil
        }
        
        init(title:String, style:UIAlertAction.Style) {
            self.title = title
            self.style = style
        }
    }
    
    // ボタンを押下した時にアラートを表示するメソッド
    func displayAlert(title:String? = nil, message:String? = nil,
                      style:UIAlertController.Style = UIAlertController.Style.alert,
                      btns:[BtnType], completion: ( (_ withType:Int) -> ())?) {
        
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:style)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        for (index, btn) in btns.enumerated() {
            var style = btn.style
            if style == nil && index == 0 {
                style = UIAlertAction.Style.cancel
            }else if style == nil{
                style = UIAlertAction.Style.default
            }
            
            // ③ UIAlertControllerにActionを追加
            let action: UIAlertAction = UIAlertAction(title: btn.title, style: style!, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                
                completion?( index )
            })
            alert.addAction(action)
        }

        // ④ Alertを表示 ※UIViewControllerのView描画完了後 アラートを表示する為MainThreadで行う
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
//    func presentViewControllerInNavigationController(rootViewController:UIViewController) {
//        let nc = UINavigationController(rootViewController: rootViewController)
//        self.present(nc, animated: true, completion: nil)
//    }
}

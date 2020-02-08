//
//  SVGKit+Additions.swift
//  recotori-ios
//
//  Created by s_nakajima on 2019/02/27.
//  Copyright © 2019 isbp. All rights reserved.
//

import Foundation
import SVGKit

extension SVGKImage{
    func setSize(size:CGSize) {
        self.size = size
    }
    
    static func customSVGKImage(contentsOf:URL?, size:CGSize?=nil) -> SVGKImage?{
        if let svg = SVGKImage.init(contentsOf: contentsOf){
            if let customSize = size{
                svg.size = customSize
            }
            
            return svg
        }
        return nil
    }
    
}




//    static func `init`(contentsOf:URL?, sizess:CGSize?=nil) -> SVGKImage?{
//        if let svg = SVGKImage.init(contentsOf: contentsOf){
//            if let customSize = size{
//                svg.size = customSize
//            }
//
//
//        }
//        return nil
//
//    }
//
//extension UIImage{
//    static func svgImage(withName name:String, andSize size:CGSize?=nil) -> UIImage?{
//
//        if let svg = SVGKImage.init(named: name){
//
//            if let customSize = size{
//                svg.scaleToFit(inside: customSize)
//            }
//
//            if let image = svg.uiImage{
//                return image.withRenderingMode(.alwaysTemplate)
//            }
//        }
//        return nil
//    }
//}

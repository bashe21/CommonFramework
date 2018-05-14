//
//  UIButton-Extension.swift
//  NGBDian
//
//  Created by 张哈哈 on 2017/6/27.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func titleLeftAndImageRightWithSpace(spacing:CGFloat) {
        let imageSize = self.imageView?.frame.size
        var titleSize = self.titleLabel?.frame.size
        let textSize = self.titleLabel?.text?.size(withAttributes: [NSAttributedStringKey.font : self.titleLabel?.font! ?? UIFont.systemFont(ofSize: 13)])
        
        let frameSize = CGSize.init(width: ceil((textSize?.width)!), height: ceil((textSize?.height)!))
        if (titleSize?.width)! + 0.5 < frameSize.width {
            titleSize?.width = frameSize.width
        }
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -((imageSize?.width)! + spacing), 0, ((imageSize?.width)! + spacing))
        self.imageEdgeInsets = UIEdgeInsetsMake(0, ((titleSize?.width)! + spacing), 0, -((titleSize?.width)! + spacing))
        
    }
    
    func titleBottomAndImageTopWithSpace(spacing:CGFloat) {
        let imageSize = self.imageView?.frame.size
        var titleSize = self.titleLabel?.frame.size
        let textSize = self.titleLabel?.text?.size(withAttributes: [NSAttributedStringKey.font : self.titleLabel?.font! ?? UIFont.systemFont(ofSize: 13)])
        let frameSize = CGSize.init(width: ceil((textSize?.width)!), height: ceil((textSize?.height)!))
        
        if (titleSize?.width)! + 0.5 < frameSize.width {
            titleSize?.width = frameSize.width
        }
        
        let totalHeight = (imageSize?.height)! + (titleSize?.height)! + spacing
        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize!.height), 0.0, 0.0, -titleSize!.width)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize!.width, -(totalHeight - titleSize!.height), 0)
    }
    
    convenience init(bgColor:UIColor,fontSize:CGFloat,title:String) {
        self.init()
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitle(title, for: .normal)
    }
}

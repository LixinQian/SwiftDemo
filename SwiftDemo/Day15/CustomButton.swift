//
//  CustomButton.swift
//  Tumblr Menu
//
//  Created by nimo on 2017/5/14.
//  Copyright © 2017年 nimoAndHisFriends. All rights reserved.
//

import UIKit

enum ButtonImagePosition: Int {
    
    case positionTop = 0
    case positionleft
    case positionBottom
    case positionRight
}

extension UIButton {
    /**
     imageName:图片的名字
     title：button 的名字
     type ：image 的位置
     Space ：图片文字之间的间距
     */
    func setImageAndTitle(imageName: String, title: String, type: ButtonImagePosition, Space space: CGFloat) {
        
        setTitle(title, for: .normal)
        setImage(UIImage(named: imageName), for: .normal)
        setTitleColor(UIColor.white, for: .normal)

        let imageWith: CGFloat = (imageView?.frame.size.width)!
        let imageHeight: CGFloat = (imageView?.frame.size.height)!
        
        var labelWidth: CGFloat = 0.0
        var labelHeight: CGFloat = 0.0
        
        labelWidth = CGFloat(titleLabel!.intrinsicContentSize.width)
        labelHeight = CGFloat(titleLabel!.intrinsicContentSize.height)
        
        var  imageEdgeInsets: UIEdgeInsets = UIEdgeInsets()
        var  labelEdgeInsets: UIEdgeInsets = UIEdgeInsets()
        
        switch type {
        case .positionTop:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith, bottom: -imageHeight-space/2.0, right: 0)
        case .positionleft:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .positionBottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWith, bottom: 0, right: 0)
        case .positionRight:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith-space/2.0, bottom: 0, right: imageWith+space/2.0)
        }
        
        // 4. 赋值
        titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}

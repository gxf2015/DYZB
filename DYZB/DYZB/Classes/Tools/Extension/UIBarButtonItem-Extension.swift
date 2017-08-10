//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/10.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit


extension UIBarButtonItem{

    convenience  init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named : imageName), for: .normal)
        
        if highImageName != ""{
            btn.setImage(UIImage(named : highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
    }

}

//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/14.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import Foundation


extension NSDate{
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }

}

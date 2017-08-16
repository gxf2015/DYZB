//
//  AncnorGroup.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/14.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit
import HandyJSON

class AncnorGroup: HandyJSON {

    var room_list : [AncnorModel]?
    
    var tag_name : String = ""
    
    var icon_name = "home_header_normal"
    
    var icon_url : String = ""
    
    required init(){}
}


class AncnorModel: HandyJSON {
    
    var room_id : Int  = 0
    
    var vertical_src : String = ""
    
    var icon_name = "home_header_normal"
    
    var isVertical : Int  = 0
    
    var room_name : String = ""
    
    var nickname : String = ""
    
    var online : Int  = 0

    var anchor_city : String = ""
    
    required init(){}
}

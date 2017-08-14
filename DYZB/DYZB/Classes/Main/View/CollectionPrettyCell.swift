//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/11.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    
      
    @IBOutlet weak var cityBtn: UIButton!
    
   override var anchor : AncnorModel? {
        didSet{
            
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
            
        }
    }
    

}

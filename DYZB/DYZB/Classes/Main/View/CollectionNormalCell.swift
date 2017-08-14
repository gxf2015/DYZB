//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/11.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
   override var anchor : AncnorModel?{
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }

}

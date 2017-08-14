//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/11.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //
    var group : AncnorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        
        }
    }
    
}

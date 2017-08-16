//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/15.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var groups : AncnorGroup?{
        didSet{
            titleLabel.text = groups?.tag_name
            guard let iconURL = URL(string: groups?.icon_url ?? "") else {
                return
            }
            iconImageView.kf.setImage(with: iconURL)
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

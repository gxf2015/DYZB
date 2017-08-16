//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/15.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            guard let iconURL = URL(string: cycleModel?.pic_url ?? "") else {
                return
            }
            iconImageView.kf.setImage(with: iconURL)
        }
    
    }

}

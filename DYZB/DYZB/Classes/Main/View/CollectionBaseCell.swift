//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/14.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AncnorModel? {
        didSet{
            //0
            guard let anchor = anchor else {
                return
            }
            //1
            var  onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(anchor.online)万在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            
            guard let iconURL = URL(string: anchor.vertical_src) else {
                return
            }
            
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
}

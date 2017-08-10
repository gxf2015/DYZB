//
//  PageContenView.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/10.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit

fileprivate let contenCellID = "contenCellID"
class PageContenView: UIView {

    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contenCellID)
        return collectionView
    }()
    
    
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageContenView{
    fileprivate func setupUI(){
        // 1.
        for chldVc in childVcs {
            parentViewController?.addChildViewController(chldVc)
        }
        // 2
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


extension PageContenView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contenCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
    
        let  childVc  = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
        
    }

}

extension PageContenView{
    func setCurrentIndex(currentIndex : Int)  {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offsetX, y : 0), animated: false)
    }
}





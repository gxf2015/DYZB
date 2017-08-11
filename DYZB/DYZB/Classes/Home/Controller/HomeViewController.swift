//
//  HomeViewController.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/10.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    fileprivate lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    fileprivate lazy var pageContenView : PageContenView = {[weak self] in
        let contenH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contenFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contenH)
    
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red:CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contenView = PageContenView(frame: contenFrame, childVcs: childVcs, parentViewController: self)
        contenView.delegate = self
        return contenView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}


extension HomeViewController {
    fileprivate func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContenView)
        pageContenView.backgroundColor = UIColor.green
    }

    private func setupNavigationBar(){
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qcodeItem]
        
    }
}

extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex : Int) {
        pageContenView.setCurrentIndex(currentIndex: selectedIndex)
    }

}

extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContenView, progress: CGFloat, sourceIndex: Int, targerIndex: Int) {
        pageTitleView.setTitleWithProgress(progress : progress, sourceIndex : sourceIndex, targerIndex : targerIndex)
    }
}

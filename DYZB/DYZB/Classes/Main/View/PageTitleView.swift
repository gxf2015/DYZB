//
//  PageTitleView.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/10.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}



fileprivate let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    fileprivate var currentIndex = 0
    fileprivate var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    fileprivate lazy var titleLabels  : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    
    }()

    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
        
    }()

    
    // MARK:-自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView{
    fileprivate func setupUI(){
       // 1.
        addSubview(scrollView)
        scrollView.frame = bounds
       // 2
        setupTitleLabels()
       // 3
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels(){
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated(){
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let  labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
        
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        //1
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        // 2
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
      
    }

}


extension PageTitleView{
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer){
    
        //1
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        //2
        let oldLabel = titleLabels[currentIndex]
        //3
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        //4
        currentIndex = currentLabel.tag
        //5
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //6
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
        
    }
}

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


//
fileprivate let kScrollLineH : CGFloat = 2
fileprivate let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
fileprivate let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


//
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
            label.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
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
        if currentLabel.tag == currentIndex {
            return
        }
        
        //2
        let oldLabel = titleLabels[currentIndex]
        //3
        currentLabel.textColor = UIColor(red: kSelectColor.0, green: kSelectColor.1, blue: kSelectColor.2)
        oldLabel.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
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


extension  PageTitleView {

    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targerIndex : Int) {
        // 1
        let sourceLabel = titleLabels[sourceIndex]
        let targerLabel = titleLabels[targerIndex]
        //2
        let moveTotalX = targerLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3
        let colorDelta  = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(red: kSelectColor.0 - colorDelta.0 * progress, green: kSelectColor.1 - colorDelta.1 * progress, blue: kSelectColor.2 - colorDelta.2 * progress)
        targerLabel.textColor = UIColor(red: kNormalColor.0 + colorDelta.0 * progress, green: kNormalColor.1 + colorDelta.1 * progress, blue: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targerIndex
    }
}





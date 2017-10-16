//
//  SQPageControl.swift
//  SQAutoScrollView
//
//  Created by ysq on 2017/10/11.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

public enum SQPageControlAlignment {
    case center
    case left
    case right
}


public enum SQPageControlStyle {
    case round
    case rectangle      
}

public class SQPageControl: UIView {
    
    public var numbersOfPages: Int = 0 {
        didSet {
            setupPageIndicatorView()
        }
    }
    
    public var currentPage: Int = 0 {
        didSet {
            setSelectedPageIndicatorView()
        }
    }
    
    public var pageIndicatorTintColor: UIColor? {
        willSet {
            guard newValue != nil else {
                return
            }
            for index in 0..<dotViewArr.count {
                let dotView = dotViewArr[index]
                dotView.set(fillColor: newValue!, state: .normal)
            }
        }
    }
    
    public var currentPageIndicatorTintColor: UIColor? {
        willSet {
            guard newValue != nil else {
                return
            }
            for index in 0..<dotViewArr.count {
                let dotView = dotViewArr[index]
                dotView.set(fillColor: newValue!, state: .selected)
            }
        }
    }
    
    public var style: SQPageControlStyle = .round {
        didSet {
            if style == .rectangle {
                pageIndicatorWidth = pageIndicatorWidth * 2.0
                pageIndicatorHeight = 5.0
            } else {
                pageIndicatorWidth = 10.0
                pageIndicatorHeight = 10.0
            }
            setupPageIndicatorView()
            for (_, dotView) in dotViewArr.enumerated() {
                dotView.style = style
            }
            
        }
    }
    
    public var alignment: SQPageControlAlignment = .center {
        didSet {
            let indicator_width = CGFloat(numbersOfPages) * pageIndicatorWidth + CGFloat(numbersOfPages - 1) * pageIndicatorSpace
            switch alignment {
                
            case .center:
                 pageIndicatorBackView.frame = CGRect(x: (self.bounds.size.width - indicator_width) / 2, y: (self.bounds.size.height - pageIndicatorViewHeight) / 2, width: indicator_width, height: pageIndicatorViewHeight)
                
            case .left:
                pageIndicatorBackView.frame = CGRect(x: 10, y: bounds.size.height - pageIndicatorViewHeight - 5, width: indicator_width, height: pageIndicatorViewHeight)
                
                
            case .right:
                pageIndicatorBackView.frame = CGRect(x: bounds.size.width - indicator_width - 10, y: bounds.size.height - pageIndicatorViewHeight - 5, width: indicator_width, height: pageIndicatorViewHeight)
            }
        }
    }
    
    private var pageIndicatorWidth: CGFloat = 10.0
    
    private var pageIndicatorHeight: CGFloat = 10.0
    
    private let pageIndicatorSpace: CGFloat = 5.0
    
    private let pageIndicatorViewHeight: CGFloat = 15.0
    
    private var pageIndicatorBackView = UIView()
    
    private var dotViewArr = [SQDotView]()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setSelectedPageIndicatorView()
    }
    
    private func setupPageIndicatorView() {
        dotViewRemoved()
        let _alignment = alignment
        alignment = _alignment
        addSubview(pageIndicatorBackView)
        addDotView()
    }
    
    private func addDotView() {
        for index in 0..<numbersOfPages {
            let x = CGFloat(index) * pageIndicatorSpace + CGFloat(index) * pageIndicatorWidth
            let dotView = SQDotView(frame: CGRect(x: x, y: (pageIndicatorViewHeight - pageIndicatorHeight) / 2, width: pageIndicatorWidth, height: pageIndicatorHeight))
            dotView.style = style
            if pageIndicatorTintColor != nil {
                dotView.set(fillColor: pageIndicatorTintColor!, state: .normal)
            } else {
                dotView.set(fillColor: UIColor.gray, state: .normal)
            }
            if currentPageIndicatorTintColor != nil {
                dotView.set(fillColor: currentPageIndicatorTintColor!, state: .selected)
            } else {
                dotView.set(fillColor: UIColor.orange, state: .selected)
            }
            dotViewArr.append(dotView)
            pageIndicatorBackView.addSubview(dotView)
        }
        
    }
    
    private func dotViewRemoved() {
        for dotView in dotViewArr {
            dotView.removeFromSuperview()
        }
        dotViewArr.removeAll()
    }
    
    private func setSelectedPageIndicatorView() {
        for (index, item) in dotViewArr.enumerated() {
            if index == currentPage {
                item.isSelected = true
            } else {
                item.isSelected = false
            }
        }
    }
    
}

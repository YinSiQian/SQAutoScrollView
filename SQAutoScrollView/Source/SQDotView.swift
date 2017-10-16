//
//  SQDotView.swift
//  SQAutoScrollView
//
//  Created by ysq on 2017/10/11.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

public enum SQDotState {
    case normal
    case selected
}

public class SQDotView: UIView {
    
    private var normalColor: UIColor? {
        willSet {
            guard newValue != nil else {
                return
            }
            backgroundColor = newValue!
        }
    }
    
    private var selectedColor: UIColor? {
        willSet {
            guard newValue != nil else {
                return
            }
            backgroundColor = newValue!
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            assert(selectedColor != nil || normalColor != nil, "please set color value")
            if isSelected {
                backgroundColor = selectedColor!
            } else {
                backgroundColor = normalColor!
            }
        }
    }
    
    public var style: SQPageControlStyle = .round {
        didSet {
            switch style {
            case .round:
                layer.cornerRadius = bounds.size.width / 2
            case .rectangle:
                layer.cornerRadius = 0
                
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
   
    
    public func set(fillColor: UIColor, state: SQDotState) {
        switch state {
        case .normal:
            self.normalColor = fillColor
        case .selected:
            self.selectedColor = fillColor
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

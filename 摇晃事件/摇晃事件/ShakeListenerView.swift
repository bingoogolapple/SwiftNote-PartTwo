//
//  ShakeListenerView.swift
//  摇晃事件
//
//  Created by bingoogol on 14/9/24.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

/*
因为UIResponder的becomeFirstResponder属性默认为false，而在监听摇晃事件时，需要把根视图变成第一响应者，因此需要自定义一个摇晃监听视图

*/
class ShakeListenerView: UIView {
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
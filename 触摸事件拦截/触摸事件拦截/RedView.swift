//
//  RedView.swift
//  触摸事件拦截
//
//  Created by bingoogol on 14/9/23.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class RedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        println("RedView init(frame: CGRect)")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        println("RedView init(coder aDecoder: NSCoder)")
    }
    
    override func awakeFromNib() {
        println("RedView awakeFromNib")
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("点击红色视图")
    }
}

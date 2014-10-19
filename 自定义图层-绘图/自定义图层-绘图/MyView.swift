//
//  MyView.swift
//  自定义图层-绘图
//
//  Created by bingoogol on 14/10/19.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MyView: UIView {
    var myLayer:MyLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        var myLayer = MyLayer()
        myLayer.bounds = self.bounds
        myLayer.position = self.center
        println("添加myLayer")
        self.layer.addSublayer(myLayer)
        myLayer.setNeedsDisplay()
        self.myLayer = myLayer
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        println("drawRect")
        // 提示：如果在使用自定义图层绘图时，UIView本身的drawRect方法内的绘图方法将失效
        // 如果使用CALayer绘图，就不要再写drawRect方法
        var r = CGRectMake(50, 50, 100, 100)
        UIRectFill(r)
    }
}
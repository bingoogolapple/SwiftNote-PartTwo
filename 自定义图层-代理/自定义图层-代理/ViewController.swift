//
//  ViewController.swift
//  自定义图层-代理
//
//  Created by bingoogol on 14/10/19.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var myLayer:CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        var myLayer = CALayer()
        myLayer.bounds = CGRectMake(0, 0, 200, 200)
        myLayer.backgroundColor = UIColor.redColor().CGColor
        myLayer.position = CGPointMake(100, 100)
        self.view.layer.addSublayer(myLayer)
        // 提示：不能将视图设置为layer的代理
        // myLayer.delegate = self.view
        myLayer.delegate = self
        // 提示：如果要重绘CALayer，必须要调用setNeedDisplay
        myLayer.setNeedsDisplay()
        println(myLayer)
    }

    /*
    使用delegate的方式，绘制图层的方法相对比较简单
    但是，因为不能将layer的delegate设置为view，因此通常使用controller作为代理
    而用controller作为代理，当controller的工作比较复杂时，此方法的可维护性不好
    */
    override func drawLayer(layer: CALayer!, inContext ctx: CGContext!) {
        println(layer)
        // 在core animation中，不能使用UI的方法，UI的方法仅适用于iOS
        // 画一个蓝色矩形
        // UIColor.blueColor().set()
        CGContextSetRGBFillColor(ctx, 0.0, 0.0, 1.0, 1.0)
        CGContextSetRGBStrokeColor(ctx, 0.0, 1.0, 0.0, 1.0)
        var rect = CGRectMake(50, 50, 100, 100)
        // UIRectFill(rect)
        CGContextAddRect(ctx, rect)
        CGContextDrawPath(ctx, kCGPathFillStroke)
    }
}
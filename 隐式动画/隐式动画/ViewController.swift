//
//  ViewController.swift
//  隐式动画
//
//  Created by bingoogol on 14/10/19.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var myLayer:CALayer!
    var colors:NSArray!
    var images:NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.实例化自定义图层
        var myLayer = CALayer()
        myLayer.bounds = CGRectMake(0, 0, 100, 100)
        myLayer.backgroundColor = UIColor.redColor().CGColor
        myLayer.position = CGPointMake(50, 50)
        self.view.layer.addSublayer(myLayer)
        self.myLayer = myLayer
        
        colors = [UIColor.redColor(),UIColor.greenColor(),UIColor.blueColor()]
        images = [UIImage(named: "头像1.png")!,UIImage(named: "头像2.png")!]
    }
    
    //文档中搜索CALayer Animatable Properties
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        var location = touch.locationInView(self.view)
        // 关闭隐式动画。通常不要关闭
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        // 位置
        myLayer.position = location
        // 颜色
        var color = arc4random_uniform(UInt32(self.colors.count))
        self.myLayer.backgroundColor = self.colors[Int(color)].CGColor
        // 透明度
        var alpha:Float = Float((arc4random_uniform(5) + 1.0) / 10) + Float(0.3)
        self.myLayer.opacity = Float(alpha)
        // 边框
        var size = arc4random_uniform(50) + 51
        self.myLayer.bounds = CGRectMake(0, 0, CGFloat(size), CGFloat(size))
        // 圆角
        var radius = arc4random_uniform(20)
        self.myLayer.cornerRadius = CGFloat(radius)
        // 旋转角度
        var angle = (CGFloat(arc4random_uniform(180)) / 180.0) * CGFloat(M_PI)
        self.myLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        // 内容
        var image = images[Int(arc4random_uniform(UInt32(images.count)))] as UIImage
        self.myLayer.contents = image.CGImage
        
        CATransaction.commit()
    }

}
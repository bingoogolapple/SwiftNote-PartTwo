//
//  ViewController.swift
//  自定义图层
//
//  Created by bingoogol on 14/10/18.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    weak var myLayer:CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.自定义图层
        var myLayer = CALayer()
        // 将自定义图层添加到视图的根图层之上
        self.view.layer.addSublayer(myLayer)
        // 2.设置属性
        // 1)设置边框
        myLayer.bounds = CGRectMake(0, 0, 200, 200)
        // 2)设置背景颜色
        myLayer.backgroundColor = UIColor.redColor().CGColor
        // 3)设置中心点，相对于父图层的位置（默认对应的是类似UIView的中心点）
        myLayer.position = CGPointMake(0, 0)
        // 4)设置内容
        var image = UIImage(named: "头像1.png")
        // 在oc中image?.CGImage需要转换成id类型
        myLayer.contents = image?.CGImage
        // 5)锚点，定位点（x,y的范围都是0-1，决定了position的定义），默认值0.5
        // 作用：主要控制图层的位置，以及旋转的轴
        myLayer.anchorPoint = CGPointMake(0, 0)
        
        myLayer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
        self.myLayer = myLayer
        
        
        // 在关节动画中可以移动锚点，保证不会肢体分离
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // 通过改变锚点来改变位置，不用知道具体的宽高。默认动画时间0.25秒
        if myLayer.anchorPoint.x == 0 {
            myLayer.anchorPoint = CGPointMake(1, 1)
        } else {
            myLayer.anchorPoint = CGPointMake(0, 0)
        }
    }

}
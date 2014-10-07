//
//  ViewController.swift
//  触摸事件
//
//  Created by bingoogol on 14/9/23.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit
// 如果希望用户手指按下屏幕就立刻做出反应，使用touchesBegan
// 如果希望用户手指离开屏幕才做出反应，使用touchesEnd
// 通常情况下应该使用touchesBegan
class ViewController: UIViewController {
    var redView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        redView = UIView(frame: CGRectMake(60, 140, 150, 150))
        redView.backgroundColor = UIColor.redColor()
        self.view.addSubview(redView)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
       // println("touchesBegan \n \(touches)")
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // 1.从NSSet中取出UITouch对象
        // 通常在单点触摸时，可以使用touches.anyObject()取出UITouch对象
        var touch = touches.anyObject() as UITouch
        // 2.知道手指触摸的位置
        var currentLocation = touch.locationInView(self.view)
        var preLocation = touch.previousLocationInView(self.view)
        // 利用preLocation处理偏移
        var deltaP = CGPoint(x: currentLocation.x - preLocation.x, y: currentLocation.y - preLocation.y)
        var newCenter = CGPoint(x: redView.center.x + deltaP.x, y: redView.center.y + deltaP.y)
        // 3.设置红色视图的位置
        redView.center = newCenter
        // println("touchesMoved \n \(touches)")
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
       // println("touchesEnded \n \(touches)")
    }
    
    // 正在滑动时，有电话打来时会被触发
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        //println("touchesCancelled \n \(touches)")
    }
}
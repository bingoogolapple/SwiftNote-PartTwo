//
//  ViewController.swift
//  CAAnimation-01基本动画
//
//  Created by bingoogol on 14/10/25.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

/**
要实现简单动画，通过touchBegan方法来触发

1.平移动画

*/
class ViewController: UIViewController {
    
    weak var myView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        var myView = UIView(frame: CGRectMake(50, 50, 100, 100))
        myView.backgroundColor = UIColor.redColor()
        self.view.addSubview(myView)
        self.myView = myView
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var location = touch.locationInView(self.view)
        // 将myView平移到手指触摸的目标点
        // self.translationAnim(location)
        
        if touch.view == self.myView {
            println("点击myView")
        }
        
        // 苹果通过块代码封装后实现相同的效果
//        UIView.animateWithDuration(1.0, animations: {
//                self.myView.center = location
//            },completion: { (finished:Bool) in
//                println("结束动画 frame:\(self.myView.frame)")
//            }
//        )
    }
    
    ///////////////////CABasic动画//////////////////
    
    // 动画代理方法
    // 动画开始(极少用)
    override func animationDidStart(anim: CAAnimation!) {
        println("开始动画")
    }
    
    // 动画结束（通常在动画结束后，做动画的后续处理）
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        var type = anim.valueForKey("animationType") as NSString
        if type.isEqualToString("translationTo") {
            // 通过键值取出需要移动到的目标点
            var point = (anim.valueForKey("targetPoint") as NSValue).CGPointValue()
            println("目标点：\(NSStringFromCGPoint(point))")
            self.myView.center = point
        }
        println("结束动画 frame:\(self.myView.frame)")
    }
    
    // 平移动画到指定点
    func translationAnim(point:CGPoint) {
        // 1.实例化动画
        // 注意：如果没有指定图层的锚点（定位点），position对应UIView的中心点
        var anim = CABasicAnimation(keyPath: "position")
        // 2.设置动画属性
        // 1)fromValue(myView的当前坐标) & toValue
        anim.toValue = NSValue(CGPoint: point)
        // 2)动画的时长
        anim.duration = 1.0
        // 3)设置代理
        anim.delegate = self
        // 4)让动画停留在目标位置
        /*
        提示：通过设置动画在完成后不删除，以及向前填充，可以做到平移动画结束后
             UIView看起来停留在目标位置，但是其本身的frame并不会发生变化
        */
        // 5)注意：要修正坐标点的实际位置可以利用setValue方法，这里的key可以随意写
        anim.setValue(NSValue(CGPoint: point), forKey: "targetPoint")
        anim.setValue("translationTo", forKey: "animationType")
        
        anim.removedOnCompletion = false
        // forward逐渐逼近目标点
        anim.fillMode = kCAFillModeForwards
        // 3.将动画添加到图层
        // 将动画添加到图层之后，系统会按照定义好的属性开始动画，通常程序员不在与动画进行交互
        self.myView.layer.addAnimation(anim, forKey: nil)
    }

}
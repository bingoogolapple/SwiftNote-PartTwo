//
//  ViewController.swift
//  摇晃事件
//
//  Created by bingoogol on 14/9/24.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    /*
    1.在视图出现在屏幕上时，让视图变成第一响应者
    2.当视图离开屏幕，应用关闭或者切换到其他视图时，注销视图的第一响应者身份
    3.监听摇晃事件
    */
    
    
    override func viewDidAppear(animated: Bool) {
        // 注意：在实现类中重写becomeFirstResponder方法并返回true
        self.view.becomeFirstResponder()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.view.resignFirstResponder()
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if UIEventSubtype.MotionShake == motion {
            println("摇晃啦！")
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        
    }
    
    override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent) {
        
    }
}
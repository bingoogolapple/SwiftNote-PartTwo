//
//  ViewController.swift
//  监听用户点击视图
//
//  Created by bingoogol on 14/9/24.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 让imageView接收用户触摸
        self.imageView.userInteractionEnabled = true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // 1.获取用户点击UITouch对象
        var touch = touches.anyObject() as UITouch
        // 2.判断用户点击到哪一个视图
        if touch.view == self.imageView {
            println("点了图像")
        } else if touch.view == self.redView {
            println("点击了红色视图")
        } else if touch.view == self.greenView {
            // 提示：最好不要直接用else处理，因为开发过程中，随时可能添加新的控件
            println("点击了绿色视图")
        }
    }

}
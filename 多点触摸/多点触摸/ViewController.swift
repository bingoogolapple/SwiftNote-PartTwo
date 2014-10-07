//
//  ViewController.swift
//  多点触摸
//
//  Created by bingoogol on 14/9/23.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

/*
在iOS中，视图默认不支持多点触摸，通过self.view.multipleTouchEnabled = true设置支持多点触摸
为了避免不必要的麻烦，也最好不要支持多点触摸
*/
class ViewController: UIViewController {
    var images:[UIImage?]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.view.multipleTouchEnabled = true
        var red = UIImage(named: "spark_red.png")
        var blue = UIImage(named: "spark_blue.png")
        self.images = [red,blue]
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // 第二部
        // 遍历touches集合来添加图像
//        var i = 0
//        for touch in touches {
//            var imageView = UIImageView(image: images[i])
//            imageView.center = touch.locationInView(self.view)
//            self.view.addSubview(imageView)
//            i++
//        }
        
        // 第一步
//        if touches.count == 1 {
//            var imageView = UIImageView(image: images[0])
//            var touch = touches.anyObject() as UITouch
//            
//            imageView.center = touch.locationInView(self.view)
//            self.view.addSubview(imageView)
//        }
        
        println("开始时子视图个数\(self.view.subviews.count)")
    }
    
    // 在touchesMoved方法中，集合中的顺序不会变
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // 第三步
        var i = 0
        for touch in touches {
            var imageView = UIImageView(image: images[i])
            imageView.center = touch.locationInView(self.view)
            self.view.addSubview(imageView)
            UIView.animateWithDuration(2, animations: {
                imageView.alpha = 0
                }, completion: { (finished:Bool) in
                    imageView.removeFromSuperview()
                }
            )
            i++
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        println("结束时子视图个数\(self.view.subviews.count)")
    }

}


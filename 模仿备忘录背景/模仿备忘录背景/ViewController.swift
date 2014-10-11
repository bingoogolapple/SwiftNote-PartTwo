//
//  ViewController.swift
//  模仿备忘录背景
//
//  Created by bingoogol on 14/10/11.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: createBackgroundImg())
    }
    
    func createBackgroundImg() -> UIImage {
        // 1.图像的上下文
        UIGraphicsBeginImageContext(CGSizeMake(320, 46))
        // 2.画图
        // 1)画背景的矩形
        var rect1 = CGRectMake(0, 0, 320, 460)
        UIColor.yellowColor().set()
        UIRectFill(rect1)
        // 2）画底部的灰线
        var rect2 = CGRectMake(0, 44, 320, 2)
        UIColor.grayColor().set()
        UIRectFill(rect2)
        // 3.获取图像
        var image = UIGraphicsGetImageFromCurrentImageContext()
        // 4.关闭上下文
        UIGraphicsEndImageContext()
        // 5.返回图像
        return image
    }

}
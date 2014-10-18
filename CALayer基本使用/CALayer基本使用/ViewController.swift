//
//  ViewController.swift
//  CALayer基本使用
//
//  Created by bingoogol on 14/10/18.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

// 在实现核心动画时，本质上是将CALayer中的内容转换成位图，从而便于图形硬件的操纵
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGrayColor()
        self.myImageLayerDemo()
    }
    
    func myImageLayerDemo() {
        var imageView = UIImageView(image: UIImage(named: "头像1.png"))
        imageView.frame = CGRectMake(150, 150, 200, 200)
        self.view.addSubview(imageView)
        // 1.圆角半径
        // 提示：在imageview中，图层不止一个，如果要实现圆角效果，需要设置一个遮罩属性
        // masksToBounds属性可以让imageView中的所有子图层跟随imageView一起变化
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        // 2.阴影
        // 提示：如果设置了masksToBounds属性，imageView的阴影效果无效
        imageView.layer.shadowColor = UIColor.redColor().CGColor
        imageView.layer.shadowOffset = CGSizeMake(0, 10)
        imageView.layer.shadowOpacity = 1.0
        // 3.边框
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.layer.borderWidth = 3
        /*
        // 4.形变属性，在CALayer中的形变属性是3D的，不再是2D的
        // 提示：形变参数在使用时，只能应用一种形变
        // 1>平移 向上移动100个点
        imageView.layer.transform = CATransform3DMakeTranslation(0, -100, 0)
        // 2>缩放属性
        imageView.layer.transform = CATransform3DMakeScale(0.5, 1.0, 1.0)
        // 3>形变参数
        // 提示：通常在旋转时指定z轴即可。图像本身没有厚度，如果按照x或y旋转90度，图像是不可见的
        // 要沿哪个轴旋转，指定一个数值1即可
        imageView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
        */
        // 5.利用keyPath设置形变，可以组合使用，但是记住不要输错。帮助文档中搜索CATransform3D Key Paths
        // 1)平移
        imageView.layer.setValue(-100, forKeyPath: "transform.translation.y")
        // 2)缩放
        imageView.layer.setValue(0.5, forKeyPath: "transform.scale")
        // 3)旋转
        imageView.layer.setValue(M_PI_4, forKeyPath: "transform.rotation.z")
    }
    
    func myViewLayerDemo() {
        
        
        // 1.自定义UIView的图层属性
        var myView = UIView(frame: CGRectMake(50, 50, 100, 100))
        myView.backgroundColor = UIColor.redColor()
        self.view.addSubview(myView)
        // 圆角
        myView.layer.cornerRadius = 50
        // 阴影
        // 因为Core Animation是跨平台的，基于QuartzCore框架
        // 在Core Animation中不能使用任何跟UI有关的方法
        // 是因为UIKit框架仅能使用与iOS平台
        // 要设置阴影，除了需要颜色之外，还需要设置偏移量和透明度
        // 1)阴影颜色
        myView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        // 2)偏移量
        myView.layer.shadowOffset = CGSizeMake(0, 10)
        // 3)透明度
        myView.layer.shadowOpacity = 1.0
        // 边框
        myView.layer.borderColor = UIColor.whiteColor().CGColor
        myView.layer.borderWidth = 3
    }

}
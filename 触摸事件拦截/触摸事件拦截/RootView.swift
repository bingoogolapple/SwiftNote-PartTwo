//
//  RootView.swift
//  触摸事件拦截
//
//  Created by bingoogol on 14/9/23.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class RootView: UIView {
    var redView:RedView!
    var greenView:GreenView!
    var blueView:BlueView!

    // 通过storyboard或者xib创建的视图，init(frame: CGRect)方法不会被调用。
    // 此时的初始化顺序是init(coder aDecoder: NSCoder) 》》 awakeFromNib
    override init(frame: CGRect) {
        super.init(frame: frame)
        println("RootView init(frame: CGRect)")
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        println("RootView init(coder aDecoder: NSCoder)")
    }
    
    override func awakeFromNib() {
        println("RootView awakeFromNib")
        redView = RedView(frame: CGRectMake(20, 210, 280, 40))
        redView.alpha = 0.5
        self.addSubview(redView)
        greenView = GreenView(frame: CGRectMake(60, 130, 200, 200))
        greenView.alpha = 0.5
        self.addSubview(greenView)
        blueView = BlueView(frame: CGRectMake(80, 150, 160, 160))
        blueView.alpha = 0.5
        self.addSubview(blueView)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("点击了RootView")
    }


    /*
    重写hitTest方法，拦截用户触摸的视图
    */
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        /*
        1.判断当前视图是否接受用户响应
        self.userInteractionEnabled = true
        self.alpha > 0.01
        self.hidden = false
        2.遍历其中的所有子视图，是否对用户触摸做出响应
        3.如果返回nil，说明当前视图及子视图均不对用户触摸做出响应。此时，把event交给上级视图或者视图控制器处理
        参数说明：
            point：参数是哟过户触摸位置相对当前视图坐标系的点
        注释：
            以下《两个》方法是联动使用的，以递归的方式判断具体响应用户事件的子视图。仅在拦截事件时才可以使用，平时不要调用
            func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView?
            func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool
            重写以上两个方法都是一样的
        提示：
            如果没有万不得已的情况，最好不要自己重写hitTest方法
        */
        //println("point:\n\(point)")
        // 需要红色视图坐标系对应的点
        var redPoint = self.convertPoint(point, toView: self.redView)
        var bluePoint = self.convertPoint(point, toView: self.blueView)
        //println("redPoint:\n\(redPoint)")
        // 使用指定视图中的坐标点判断该点是否在对应视图内部
        if self.blueView.pointInside(bluePoint, withEvent: event) {
            return blueView
        } else if self.redView.pointInside(redPoint, withEvent: event) {
            return self.redView
        }
        return super.hitTest(point, withEvent: event)
    }
    
}
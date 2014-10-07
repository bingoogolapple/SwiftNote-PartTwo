//
//  MyView.swift
//  基本绘图
//
//  Created by bingoogol on 14/10/7.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    override func drawRect(rect: CGRect) {
        drawLine()
    }
    
    
    func drawLine() {
        // 1.获取上下文
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        // 2.创建可变的路径并设置路径
        var path:CGMutablePathRef = CGPathCreateMutable()
        // 1)设置起始点
        CGPathMoveToPoint(path, nil, 50, 50)
        // 2)设置目标点
        CGPathAddLineToPoint(path, nil, 200, 200)
        CGPathAddLineToPoint(path, nil, 50, 200)
        // 3)封闭路径
        // CGPathAddLineToPoint(path, nil, 50, 50)
        CGPathCloseSubpath(path)
        
        // 3.将路径添加到上下文
        CGContextAddPath(context, path)
        // 4.设置上下文属性
        /*
        red/green/blue 0 ~ 1.0 red/255
        alpha 透明度 0 ~ 1.0   0完全透明   1完全不透明
        提示：
            1)在使用rgb颜色设置时，最好不要同时制定rgb和alpha，否则会对性能造成一定影响
            2)默认线条和填充颜色都是黑色
        */
        // 设置线条颜色和填充颜色
        CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0)
        CGContextSetRGBFillColor(context, 0, 1.0, 0, 1.0)
        // 设置线条宽度
        CGContextSetLineWidth(context, 5.0)
        // 设置线条的顶点样式
        CGContextSetLineCap(context, kCGLineCapRound)
        // 设置线条连接点样式
        CGContextSetLineJoin(context, kCGLineJoinRound)
        // 设置线条的虚线样式
        /*
        phase 相位，虚线起始的位置，通常使用0即可，从头开始画虚线
        lengths 长度的数组
        count lengths数组的个数
        */
        CGContextSetLineDash(context, 10, [20,10], 2)
        // 5.绘制路径
        /*
        var kCGPathFill:填充（实心）
        var kCGPathEOFill:
        var kCGPathStroke:画线（空心）
        var kCGPathFillStroke:即画线又填充
        var kCGPathEOFillStroke:
        */
        CGContextDrawPath(context, kCGPathFillStroke)
        // 6.释放路径
        // swift中不需要释放
    }
    
}
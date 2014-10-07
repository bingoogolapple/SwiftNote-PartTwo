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
        drawImage(UIGraphicsGetCurrentContext())
    }
    
    func drawImage(context:CGContextRef) {
        var image = UIImage(named: "头像1.png")
        // 提示：绘制之后就无法改变位置，也没有办法监听手势识别
        // 在指定点绘制图像
        //image?.drawAtPoint(CGPointMake(50, 50))
        // 会在指定的矩形中拉伸绘制
        //image?.drawInRect(self.bounds)
        // 在指定区域中平铺图像
        image?.drawAsPatternInRect(self.bounds)
    }
    
    func drawText(context:CGContextRef) {
        var string:NSString = "Hello World NSAttributedString NSAttributedString NSAttributedString NSAttributedString"
        var font:UIFont = UIFont(name: "Marker Felt", size: 40)!
        //string.drawAtPoint(CGPointMake(100, 100), withAttributes: ["font":font])
        
        // 如果在UILabel中，可以将numbersOfLine设置为0，并且指定足够的高度即可
        
        string.drawInRect(CGRectMake(100, 100, 200,100), withAttributes: nil)
    }
    
    
    func drawShapeArc(context:CGContextRef) {
        /*
        1）context 上下文
        2）x,y 圆弧所在圆的的中心点坐标
        3）radius 半径，所在圆的半径
        4）startAngle、endAngle 起始角度、截止角度  单位是弧度
            0度对应的是圆的最右侧点
        5）clockwise 顺时针0，逆时针1
        */
        UIColor.greenColor().setFill()
        CGContextAddArc(context, 100, 100, 50, CGFloat(-M_PI_4), CGFloat(M_PI_2), 1)
        CGContextDrawPath(context, kCGPathFill)
    }
    
    func drawShapeCircle() {
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        var rect = CGRectMake(50, 50, 200, 100)
        UIRectFrame(rect)
        CGContextAddEllipseInRect(context, rect)
        CGContextDrawPath(context, kCGPathStroke)
    }
    
    // 绘制矩形
    func drawShapeRect() {
        /*
        在程序开发中，无论肉眼看到的是什么形状的对象，其本质都是矩形的
        */
        var rect = CGRectMake(50, 50, 200, 200)
        // 绘制实心矩形
        UIColor.greenColor().setFill()
        UIRectFill(rect)
        // 绘制空心矩形
        UIColor.redColor().setStroke()
        UIRectFrame(CGRectMake(50, 300, 100, 100))
    }
    
    // 使用默认的context进行绘制
    func drawLine2() {
        // 1.获取上下文
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        // 2.设置路径
        CGContextMoveToPoint(context, 50, 50)
        CGContextAddLineToPoint(context, 200, 200)
        CGContextAddLineToPoint(context, 50, 200)
        CGContextClosePath(context)
        // 3.设置属性
        /*
        UIKit会默认导入Core Graphics框架，UIKit对常用的很多CG方法做了封装
        setStroke设置边线   setFill设置填充  set设置边线和填充
        */
        // 设置边线
        UIColor.redColor().setStroke()
        // 设置填充
        UIColor.greenColor().setFill()
        // 设置边线和填充
        // UIColor.blueColor().set()
        // 4.绘制路径，虽然没有直接定义路径，但是第2步操作就是为上下文指定路径
        CGContextDrawPath(context, kCGPathFillStroke)
    }
    
    func drawLine() {
        // 1.获取上下文
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        // 2.创建可变的路径并设置路径
        // 注意：当我们开发动画的时候，通常需要指定图像运动的路径，然后由动画方法负责实现动画效果，因此，在动画开发中，需要熟练使用路径
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
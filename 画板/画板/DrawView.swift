//
//  DrawView.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var drawPath:CGMutablePathRef!
    var drawPathArray:NSMutableArray!
    var lineWidth:CGFloat!
    var lineCap:CGLineCap!
    var drawColor:UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.drawPathArray = NSMutableArray()
        self.lineWidth = 10.0
        self.drawColor = UIColor.redColor()
        self.lineCap = kCGLineCapRound
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // 注意：drawRect方法每次都是完成的绘制视图中需要绘制部分的内容
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        self.drawView(context)
    }
    
    func drawView(context:CGContextRef) {
        // 首先将绘图数组中的路径全部绘制出来
        for path in self.drawPathArray {
            var tempPath = path as DrawPath
            CGContextAddPath(context, tempPath.path)
            
            tempPath.drawColor.set()
            CGContextSetLineWidth(context, tempPath.lineWidth)
            CGContextSetLineCap(context, tempPath.lineCap)
            
            CGContextDrawPath(context, kCGPathStroke)
        }
        
        // 以下代码绘制当前路径的内容，就是手指还没有离开屏幕
        // 1.绘制路径
        CGContextAddPath(context, self.drawPath)
        // 2.设置上下文属性
        self.drawColor.set()
        CGContextSetLineWidth(context, self.lineWidth)
        CGContextSetLineCap(context, self.lineCap)
        // 3.绘制路径
        CGContextDrawPath(context, kCGPathStroke)
    }
    
    // 触摸开始创建绘图路径
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.drawPath = CGPathCreateMutable()
        var touch = touches.anyObject() as UITouch
        var location = touch.locationInView(self)
        CGPathMoveToPoint(self.drawPath, nil, location.x, location.y)
    }
    
    // 移动过程中将触摸点不断添加到绘图路径
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var location = touch.locationInView(self)
        CGPathAddLineToPoint(self.drawPath, nil, location.x, location.y)
        self.setNeedsDisplay()
    }
    
    // 触摸结束，释放路径
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // 一笔画完之后，将完整的路径添加到路径数组之中
        // 在oc中要将CGPathRdf添加到NSArray之中，需要借助贝塞尔曲线对象（swift中可以直接加了，不用转换）
        // 贝塞尔曲线是UIKit对CGPathRef的一个封装，贝塞尔路径的对象可以直接添加到数组
        // var path = UIBezierPath(CGPath: self.drawPath)
        
        var path = DrawPath.drawPathWithCGPath(self.drawPath, drawColor: self.drawColor, lineWidth: self.lineWidth,lineCap:self.lineCap)
        self.drawPathArray.addObject(path)
        
        // 测试线宽
        self.lineWidth = CGFloat(arc4random()) % 10 + 1
    }
    
}
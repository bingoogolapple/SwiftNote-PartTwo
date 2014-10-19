//
//  MyLayer.swift
//  自定义图层-绘图
//
//  Created by bingoogol on 14/10/19.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MyLayer: CALayer {
    override func drawInContext(ctx: CGContext!) {
        println("drawInContext")
        // 绘制图层
        // 1.青色的圆
        CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 100, 100))
        CGContextSetRGBFillColor(ctx, 0.0, 1.0, 1.0, 1.0)
        CGContextDrawPath(ctx, kCGPathFill)
        
        // 2.蓝色的圆
        CGContextAddEllipseInRect(ctx, CGRectMake(100, 100, 100, 100))
        CGContextSetRGBFillColor(ctx, 0.0, 0.0, 1.0, 1.0)
        CGContextDrawPath(ctx, kCGPathFill)
        
        
        // 3.绘制头像
        /*
        可以利用的资源：
        1）在绘图的时候可以利用上下文的形变
        2) 可以利用形变属性的缩放实现图片的反转（1，-1）
        3) 利用平移缩放位置(向下平移坐标系)
        */
        CGContextSaveGState(ctx)
        // a）反转
        CGContextScaleCTM(ctx, 1, -1)
        // b) 平移坐标系
        CGContextTranslateCTM(ctx, 0, -self.bounds.height)
        var image = UIImage(named: "头像2.png")
        CGContextDrawImage(ctx, CGRectMake(50, 50, 100, 100), image.CGImage)
        CGContextRestoreGState(ctx)
    }
}
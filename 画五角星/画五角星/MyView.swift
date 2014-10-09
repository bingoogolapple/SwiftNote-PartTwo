//
//  MyView.swift
//  画五角星
//
//  Created by bingoogol on 14/10/9.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        /**
        CGContextTranslateCTM
        CGContextRotateCTM
        CGContextScaleCTM
        注意：调整上下文之前需要备份上下文，调整之后需要恢复
        */
        
        /*
        // 绘图前先保存context
        CGContextSaveGState(context)
        // 对context进行旋转
        CGContextRotateCTM(context, CGFloat(M_PI_2 / 6))
        drawStar(context,center:CGPointMake(150, 150),radius:100)
        // 绘图之后恢复context，从而保证下一个又能够从初始状态进行绘制
        CGContextRestoreGState(context)
        
        
        CGContextSaveGState(context)
        // 对context进行缩放
        CGContextScaleCTM(context, 0.7, 1.0)
        drawStar(context,center:CGPointMake(250, 300),radius:50)
        CGContextRestoreGState(context)
        */
        
        for i in 0 ... 9 {
            var center = CGPointMake(CGFloat(arc4random_uniform(320)), CGFloat(arc4random_uniform(500)))
            var radius:CGFloat = CGFloat(arc4random()) % 50 + 50
            drawStar(context, center: center, radius: radius)
        }
    }
    
    func drawStar(context:CGContextRef,center:CGPoint,radius:CGFloat) {
        /*
        绘制五角星需要以下条件
        1.圆心 center
        2.半径 r
        3.顶点 center.x,center.y - r
        4.每次旋转(2 * M_PI / 5.0) * 2 = 144 度
        */
        // 1.设置路径
        // 1)初始条件
        
        var point1 = CGPointMake(center.x, center.y - radius)
        var angle:CGFloat = 4 * CGFloat(M_PI) / 5
        // 2)起始点
        randomColor().set()
        CGContextMoveToPoint(context, point1.x, point1.y)
        // 3)设置路径，计算其他四个点得坐标
        // 技巧，画负责的边角图形时，一个一个计算调试，否则以下画太多点，不好调试
        for i in 1 ... 4 {
            // 下一目标点的坐标
            var newAngle:Float = Float(angle * CGFloat(i) - CGFloat(M_PI_2))
            var x:CGFloat = CGFloat(cosf(newAngle)) * radius
            var y:CGFloat = CGFloat(sinf(newAngle)) * radius
            
            CGContextAddLineToPoint(context, center.x + x, center.y + y)
        }
        CGContextClosePath(context)
        
        // 4)绘制
        CGContextDrawPath(context, kCGPathFill)
    }
    
    func randomColor() -> UIColor {
        /*
        r g g 0 ~ 1
        */
        var r = CGFloat(arc4random_uniform(255)) / 255
        var g = CGFloat(arc4random_uniform(255)) / 255
        var b = CGFloat(arc4random_uniform(255)) / 255
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}
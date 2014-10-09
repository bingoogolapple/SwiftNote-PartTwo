//
//  MyRoateView.swift
//  画五角星
//
//  Created by bingoogol on 14/10/9.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MyRoateView: UIView {
    var points:[CGPoint] = [CGPoint]()
    var hasPoint:Bool = false
    
    override func drawRect(rect: CGRect) {
        if !hasPoint {
            // 计算五个点
            println("计算五个点")
            hasPoint = true
            self.loadPoints()
        }
        // drawStar(UIGraphicsGetCurrentContext())
        drawRandomStar(UIGraphicsGetCurrentContext(),count:20)
    }
    
    func loadPoints() {
        var angle:CGFloat = 4 * CGFloat(M_PI) / 5
        var radius:CGFloat = 100
        points.append(CGPointMake(0, -radius))
        
        for i in 1 ... 4 {
            var newAngle:Float = Float(angle * CGFloat(i) - CGFloat(M_PI_2))
            var x:CGFloat = CGFloat(cosf(newAngle)) * radius
            var y:CGFloat = CGFloat(sinf(newAngle)) * radius
            points.append(CGPointMake(x, y))
        }
    }
    
    func drawRandomStar(context:CGContextRef,count:Int) {
        for i in 1 ... count {
            CGContextSaveGState(context)
            
            var tx = CGFloat(arc4random()) % bounds.width
            var ty = CGFloat(arc4random()) % bounds.height
            CGContextTranslateCTM(context, tx, ty)
            
            var angle = CGFloat(arc4random()) % 180 * CGFloat(M_PI) / 180
            CGContextRotateCTM(context, angle)
            
            var scale = CGFloat(arc4random_uniform(5)) / 10 + 0.3
            CGContextScaleCTM(context, scale, scale)
            
            drawStar(context)
            CGContextRestoreGState(context)
        }
    }
    
    func drawStar(context:CGContextRef) {
        randomColor().set()
        CGContextMoveToPoint(context, points[0].x, points[0].y)
        for i in 1 ... 4 {
            CGContextAddLineToPoint(context, points[i].x, points[i].y)
        }
        CGContextClosePath(context)
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
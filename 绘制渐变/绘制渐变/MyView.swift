//
//  MyView.swift
//  绘制渐变
//
//  Created by bingoogol on 14/10/11.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        self.drawGradient(context)
    }
    
    func drawGradient(context:CGContextRef) {
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var compoints:[CGFloat] = [1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0]
        var locations:[CGFloat] = [0.3, 1.0]
        /*
        1) context
        2) gradient
        3) startCenter 起始中心点
        4) startRadius 起始半径，如果指定为0，就从圆心开始渐变，否则会空出指定半径的位置不填充
        5) endCenter 截止点（通常和起始中心点重合，即便偏移也不会太大）
        6) endRadius 截止半径
        7) 渐变填充方式
        */
        var gradient = CGGradientCreateWithColorComponents(colorSpace, compoints, locations, UInt(locations.count))
        CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 230), 5, CGPointMake(160, 230), 150, UInt32(kCGGradientDrawsAfterEndLocation))

    }
    
    
    // 绘制线性渐变
    func drawLinearGradient(context:CGContextRef) {
        // 1.创建颜色空间
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        /*
        参数说明：
        1.colorSpace 颜色空间 rgb
        2.components 数组,每4个一组，表示一个颜色[r,g,b,a,r,g,b,a]
        3.location 表示渐变开始的位置
        */
        // 2.创建渐变
        var compoints:[CGFloat] = [1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0]
        var locations:[CGFloat] = [0.0, 1.0]
        var gradient = CGGradientCreateWithColorComponents(colorSpace, compoints, locations, UInt(locations.count))
        // 渐变的区域裁剪
        // 提示：整个渐变实际上是完整绘制在屏幕上的，通过裁剪区域可以让指定范围内显示渐变效果
        // CGContextClipToRect(context, CGRectMake(100, 200, 150, 200))
        // 3.设置裁剪区域范围
        var rects = [
            CGRectMake(0, 0, 100, 100),
            CGRectMake(100, 100, 100, 100),
            CGRectMake(200, 200, 100, 100),
            CGRectMake(0, 200, 100, 100),
            CGRectMake(200, 0, 100, 100)
        ]
        CGContextClipToRects(context, rects, UInt(rects.count))
        // 4.绘制渐变
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(320, 480),UInt32(kCGGradientDrawsAfterEndLocation))
        
    }
}
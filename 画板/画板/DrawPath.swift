//
//  DrawPath.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class DrawPath: NSObject {
    var path:CGPathRef!
    var lineWidth:CGFloat!
    var lineCap:CGLineCap!
    var drawColor:UIColor!
    
    class func drawPathWithCGPath(path:CGPathRef,drawColor:UIColor,lineWidth:CGFloat,lineCap:CGLineCap) -> DrawPath {
        var drawPath = DrawPath()
        drawPath.path = path
        drawPath.drawColor = drawColor
        drawPath.lineWidth = lineWidth
        drawPath.lineCap = lineCap
        return drawPath
    }
}
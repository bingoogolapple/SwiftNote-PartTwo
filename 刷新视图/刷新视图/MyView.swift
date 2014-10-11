//
//  MyView.swift
//  刷新视图
//
//  Created by bingoogol on 14/10/11.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MyView: UIView {
    var text:NSString!
    var fontSize:CGFloat!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        self.text = "Hello World"
        self.fontSize = 16
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        var paragraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        paragraphStyle.alignment = NSTextAlignment.Center
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        let attributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(self.fontSize),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSParagraphStyleAttributeName:paragraphStyle
        ]
        self.text.drawInRect(self.bounds, withAttributes: attributes)
    }
    
    func setFontSize(fontSize:CGFloat) {
        self.fontSize = fontSize
        self.setNeedsDisplay()
    }
    
    func setText(text:NSString) {
        self.text = text
        self.setNeedsDisplay()
    }
}
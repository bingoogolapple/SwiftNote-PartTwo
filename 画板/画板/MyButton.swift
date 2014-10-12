//
//  MyButton.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    var selectedMyButton:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backgroundColor = UIColor.blueColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        if self.selectedMyButton {
            // 绘制红线
            var lineRect = CGRectMake(0, self.bounds.size.height - 2, self.bounds.width, 2)
            UIColor.redColor().set()
            UIRectFill(lineRect)
        }
    }
    
    func setSelectedMyButton(selectedMyButton:Bool) {
        self.selectedMyButton = selectedMyButton
        self.setNeedsDisplay()
    }
    
}
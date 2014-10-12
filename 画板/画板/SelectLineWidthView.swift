//
//  SelectLineWidthView.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

typealias SelectLineWidthBlock = (lineWidth:Int) -> Void

class SelectLineWidthView: UIView {
    let kButtonSpace:CGFloat = 10.0
    var lineWidthArray:NSArray!
    var selectLineWidthBlock:SelectLineWidthBlock!
    init(frame: CGRect,selectLineWidthBlock:SelectLineWidthBlock) {
        super.init(frame: frame)
        self.selectLineWidthBlock = selectLineWidthBlock
        
        self.backgroundColor = UIColor.grayColor()
        var array = [1,3,5,7,9,11,13]
        self.lineWidthArray = array
        createButtonsWithArray(array)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createButtonsWithArray(array:NSArray) {
        var button:UIButton
        let spaceCountWidth = CGFloat(array.count + 1) * kButtonSpace
        let buttonWidth = (self.bounds.width - spaceCountWidth) / CGFloat(array.count)
        for (index,text) in enumerate(array) {
            button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.backgroundColor = UIColor.orangeColor()
            button.addTarget(self, action: Selector("tapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = index
            button.setTitle("\(lineWidthArray[index])点", forState: UIControlState.Normal)
            let startX = CGFloat(index) * (buttonWidth + kButtonSpace) + kButtonSpace
            button.frame = CGRectMake(startX, 8, buttonWidth, self.bounds.height - 16)
            self.addSubview(button)
        }
    }
    
    func tapButton(button:MyButton) {
        self.selectLineWidthBlock(lineWidth:self.lineWidthArray[button.tag] as Int)
    }
}

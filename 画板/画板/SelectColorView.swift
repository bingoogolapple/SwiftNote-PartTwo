//
//  SelectColorView.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

typealias SelectColorBlock = (color:UIColor) -> Void

class SelectColorView: UIView {
    let kButtonSpace:CGFloat = 10.0
    var colorArray:NSArray!
    var selectColorBlock:SelectColorBlock!
    init(frame: CGRect,selectColorBlock:SelectColorBlock) {
        super.init(frame: frame)
        self.selectColorBlock = selectColorBlock
        
        self.backgroundColor = UIColor.grayColor()
        var array = [UIColor.lightGrayColor(),UIColor.redColor(),UIColor.greenColor(),UIColor.blueColor(),UIColor.yellowColor(),UIColor.orangeColor(),UIColor.purpleColor(),UIColor.brownColor(),UIColor.blackColor()]
        self.colorArray = array
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
            button.backgroundColor = array[index] as? UIColor
            button.addTarget(self, action: Selector("tapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = index
            let startX = CGFloat(index) * (buttonWidth + kButtonSpace) + kButtonSpace
            button.frame = CGRectMake(startX, 8, buttonWidth, self.bounds.height - 16)
            self.addSubview(button)
        }
    }
    
    func tapButton(button:MyButton) {
        self.selectColorBlock(color:self.colorArray[button.tag] as UIColor)
    }
}
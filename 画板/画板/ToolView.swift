//
//  ToolView.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ToolView: UIView {
    let kButtonSpace:CGFloat = 10
    weak var selectedButton:MyButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        var array = ["颜色","线宽","橡皮","撤销","清屏","相机","保存"]
        createButtonsWithArray(array)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createButtonsWithArray(array:NSArray) {
        var button:MyButton
        let spaceCountWidth = CGFloat(array.count + 1) * kButtonSpace
        let buttonWidth = (self.bounds.width - spaceCountWidth) / CGFloat(array.count)
        for (index,text) in enumerate(array) {
            button = MyButton.buttonWithType(UIButtonType.Custom) as MyButton
            button.setTitle(text as NSString, forState: UIControlState.Normal)
            button.addTarget(self, action: Selector("tapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = index
            let startX = CGFloat(index) * (buttonWidth + kButtonSpace) + kButtonSpace
            button.frame = CGRectMake(startX, 8, buttonWidth, self.bounds.height - 16)
            self.addSubview(button)
        }
    }
    
    func tapButton(button:MyButton) {
        if self.selectedButton != nil && selectedButton != button {
            self.selectedButton.setSelectedMyButton(false)
        }
        self.selectedButton = button
        self.selectedButton.setSelectedMyButton(true)
        
    }
}
//
//  ToolView.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

enum ButtonActionType : Int {
    case kButtonColor
    case kButtonLineWidth
    case kButtonEarser
    case kButtonUndo
    case kButtonClearScreen
    case kButtonCamera
    case kButtonSave
}

//typealias EarserBlock = () -> Void
//typealias UndoBlock = () -> Void
//typealias ClearScreenBlock = () ->Void
//typealias PhotoBlock = () ->Void

typealias ToolViewActionBlock = () -> Void

class ToolView: UIView {
    let kButtonSpace:CGFloat = 10.0
    weak var selectedButton:MyButton!
    var holderView:UIView!
    var currentHolderView:UIView!
    
    var selectColorView:SelectColorView!
    var selectColorBlock:SelectColorBlock!
    
    var selectLineWidthView:SelectLineWidthView!
    var selectLineWidthBlock:SelectLineWidthBlock!
    
    var earserBlock:ToolViewActionBlock!
    var undoBlock:ToolViewActionBlock!
    var clearScreenBlock:ToolViewActionBlock!
    var photoBlock:ToolViewActionBlock!
    
    init(frame: CGRect,selectColorBlock:SelectColorBlock,selectLineWidthBlock:SelectLineWidthBlock,earserBlock:ToolViewActionBlock,undoBlock:ToolViewActionBlock,clearScreenBlock:ToolViewActionBlock,photoBlock:ToolViewActionBlock) {
        super.init(frame: frame)
        self.selectColorBlock = selectColorBlock
        self.selectLineWidthBlock = selectLineWidthBlock
        self.earserBlock = earserBlock
        self.undoBlock = undoBlock
        self.clearScreenBlock = clearScreenBlock
        self.photoBlock = photoBlock
        
        self.backgroundColor = UIColor.lightGrayColor()
        
        // 添加占位视图
        holderView = UIView(frame: self.bounds)
        self.addSubview(holderView)
        
        // 添加遮罩视图
        var maskView = UIView(frame: self.bounds)
        maskView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(maskView)
        
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
        button.setSelectedMyButton(true)
        self.selectedButton = button
        
        switch ButtonActionType(rawValue: button.tag)! {
        case ButtonActionType.kButtonColor:
            self.showHiddenSelectColorView()
        case ButtonActionType.kButtonLineWidth:
            self.showHiddenSelectLineWidthView()
        case ButtonActionType.kButtonEarser:
            self.hiddenHolderView()
            self.earserBlock()
        case ButtonActionType.kButtonUndo:
            self.hiddenHolderView()
            self.undoBlock()
        case ButtonActionType.kButtonClearScreen:
            self.hiddenHolderView()
            self.clearScreenBlock()
        case ButtonActionType.kButtonCamera:
            self.hiddenHolderView()
            self.photoBlock()
        default:
            break
        }
    }
    
    func showHiddenSelectLineWidthView() {
        if self.selectLineWidthView == nil {
            var selectLineWidthView = SelectLineWidthView(frame: self.holderView.bounds, selectLineWidthBlock: { (lineWidth:Int) in
                self.selectLineWidthBlock(lineWidth:lineWidth)
                self.showHiddenSelectLineWidthView()
            })
            self.selectLineWidthView = selectLineWidthView
        }
        showHiddenHolderView(self.selectLineWidthView)
    }
    
    func showHiddenSelectColorView() {
        if self.selectColorView == nil {
            var selectColorView = SelectColorView(frame: self.holderView.bounds, selectColorBlock: { (color:UIColor) in
                self.selectColorBlock(color:color)
                self.showHiddenSelectColorView()
            })
            self.selectColorView = selectColorView
        }
        showHiddenHolderView(self.selectColorView)
    }
    
    func showHiddenHolderView(selectedView:UIView) {
        var isNeedAnimate = true
        if self.currentHolderView == nil {
            self.holderView.addSubview(selectedView)
            self.currentHolderView = selectedView
            
            var holderToFrame = self.holderView.frame
            var toolToFrame = self.frame
            holderToFrame.origin.y = 44
            toolToFrame.size.height = 88
            
            UIView.animateWithDuration(0.5, animations: {
                self.frame = toolToFrame
                self.holderView.frame = holderToFrame
            })
        } else {
            if self.currentHolderView == selectedView {
                hiddenHolderView()
            } else {
                currentHolderView.removeFromSuperview()
                self.holderView.addSubview(selectedView)
                self.currentHolderView = selectedView
            }
        }
    }
    
    func hiddenHolderView() {
        if self.currentHolderView != nil {
            var holderToFrame = self.holderView.frame
            var toolToFrame = self.frame
            holderToFrame.origin.y = 0
            toolToFrame.size.height = 44
            
            UIView.animateWithDuration(0.5, animations: {
                self.frame = toolToFrame
                self.holderView.frame = holderToFrame
                },completion: { (finished:Bool) in
                    self.currentHolderView.removeFromSuperview()
                    self.currentHolderView = nil
                }
            )
        }
    }
    
}
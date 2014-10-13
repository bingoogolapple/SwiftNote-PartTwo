//
//  ViewController.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    let TOOL_HEIGHT:CGFloat = 44.0
    weak var drawView:DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = UIScreen.mainScreen().applicationFrame
        
        var drawView = DrawView(frame: CGRectMake(0, TOOL_HEIGHT + frame.origin.y, frame.width, frame.height - TOOL_HEIGHT))
        self.view.addSubview(drawView)
        self.drawView = drawView
        
        var toolView = ToolView(frame: CGRectMake(0, frame.origin.y, frame.width, TOOL_HEIGHT),selectColorBlock:{ (color:UIColor) -> Void in
                self.drawView.drawColor = color
            },selectLineWidthBlock:{ (lineWidth:Int) in
                self.drawView.lineWidth = CGFloat(lineWidth)
            },earserBlock:{
                self.drawView.drawColor = UIColor.whiteColor()
            },undoBlock:{
                self.drawView.undo()
            },clearScreenBlock:{
                self.drawView.clearScreen()
            },photoBlock:{
                // 弹出图像选择窗口
                var imagePicker = UIImagePickerController()
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        )
        self.view.addSubview(toolView)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        self.drawView.setImage(image)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
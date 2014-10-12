//
//  ViewController.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let TOOL_HEIGHT:CGFloat = 44.0
    var drawView:DrawView!
    var toolView:ToolView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = UIScreen.mainScreen().applicationFrame
        
        self.drawView = DrawView(frame: CGRectMake(0, TOOL_HEIGHT + frame.origin.y, frame.width, frame.height - TOOL_HEIGHT))
        self.view.addSubview(drawView)
        
        self.toolView = ToolView(frame: CGRectMake(0, frame.origin.y, frame.width, TOOL_HEIGHT),selectColorBlock:{ (color:UIColor) -> Void in
                self.drawView.drawColor = color
            },selectLineWidthBlock:{ (lineWidth:Int) in
                self.drawView.lineWidth = CGFloat(lineWidth)
            }
        )
        self.view.addSubview(toolView)
    }
    
}
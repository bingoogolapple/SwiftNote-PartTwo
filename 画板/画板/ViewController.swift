//
//  ViewController.swift
//  画板
//
//  Created by bingoogol on 14/10/12.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var drawView:DrawView!

    override func viewDidLoad() {
        super.viewDidLoad()
        drawView = DrawView(frame: self.view.bounds)
        self.view.addSubview(drawView)
    }

}
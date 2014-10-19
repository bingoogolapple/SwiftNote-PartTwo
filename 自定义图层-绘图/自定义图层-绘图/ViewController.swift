//
//  ViewController.swift
//  自定义图层-绘图
//
//  Created by bingoogol on 14/10/19.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var myView = MyView(frame: CGRectMake(0, 0, 200, 200))
        myView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(myView)
        
        
    }

}
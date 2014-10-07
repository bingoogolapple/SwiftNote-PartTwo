//
//  GreenView.swift
//  触摸事件拦截
//
//  Created by bingoogol on 14/9/23.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class GreenView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("点击绿色视图")
    }


}

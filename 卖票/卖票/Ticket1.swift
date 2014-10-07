//
//  Ticket1.swift
//  卖票
//
//  Created by bingoogol on 14/9/19.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class Ticket1: NSObject {
    
    class var shared:Ticket1 {
        if Inner.instance == nil {
            Inner.instance = Ticket1()
        }
        return Inner.instance!
    }
    
    struct Inner {
        static var instance: Ticket1?
    }

}
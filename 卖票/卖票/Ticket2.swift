//
//  Ticket2.swift
//  卖票
//
//  Created by bingoogol on 14/9/19.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class Ticket2: NSObject {
    class var shared:Ticket2 {
        return Inner.instance
    }
    
    struct Inner {
        static var instance = Ticket2()
    }

}

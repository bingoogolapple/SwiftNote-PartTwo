//
//  Ticket.swift
//  卖票
//
//  Created by bingoogol on 14/9/18.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class Ticket: NSObject {
    var tickets:Int = 0
    
    class var shared: Ticket {
        dispatch_once(&Inner.token) {
            Inner.instance = Ticket()
        }
        return Inner.instance!
    }
    
    class func sharedTicket() -> Ticket {
        dispatch_once(&Inner.token) {
            Inner.instance = Ticket()
        }
        return Inner.instance!
    }

    
    struct Inner {
        static var instance: Ticket?
        static var token: dispatch_once_t = 0
    }
}
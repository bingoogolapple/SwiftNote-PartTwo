//
//  Book.swift
//  KVC
//
//  Created by bingoogol on 14/10/14.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class Book: NSObject {
    var bookName:NSString!
    var price:NSNumber!
    
    override var description:String {
        return "bookName:\(bookName)   price:\(price)"
    }
}
//
//  Person.swift
//  KVC
//
//  Created by bingoogol on 14/10/13.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name:NSString!
    
    var age:NSNumber!
    
    var card:Card!
    
    var books:NSArray!
    
    override var description:String {
        return "name->\(name)   age->\(age)   card->\(card) books->\(books)"
    }
}
//
//  Person.swift
//  SQLite基本使用
//
//  Created by bingoogol on 14/10/26.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class Person: NSObject {
    var ID:NSInteger!
    var name:NSString!
    var age:NSInteger!
    var phoneNo:NSString!
    
    override var description: String {
        return "<Person ID:\(ID) name:\(name) age:\(age) phoneNo:\(phoneNo)>"
    }
    
    /**
    工厂方法
    
    :param: ID      ID
    :param: name    姓名
    :param: age     年龄
    :param: phoneNo 电话
    
    :returns: 个人信息对象
    */
    class func personWithID(ID:NSInteger,name:NSString,age:NSInteger,phoneNo:NSString) -> Person {
        var person = Person()
        person.ID = ID
        person.name = name
        person.age = age
        person.phoneNo = phoneNo
        return person
    }
    
    class func personWithName(name:NSString,age:NSInteger,phoneNo:NSString) -> Person {
        var person = Person()
        person.name = name
        person.age = age
        person.phoneNo = phoneNo
        return person
    }
    
}
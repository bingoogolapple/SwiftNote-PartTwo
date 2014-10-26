//
//  ViewController.swift
//  SQLite基本使用
//
//  Created by bingoogol on 14/10/26.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

/**
在应用程序第一次运行时，由于沙盒中没有数据库，所以需要创建一个空的数据库
创建数据库之后，为了保证能够正常运行，通常需要做一些初始化工作，其中最重要的一项工作就是创建数据表
而再次使用时就无需再创建数据表
*/
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.initData()
        
        var persons = PersonManager.sharedPersonManager().allPersons()
        println((persons![0] as Person).name)
    }
    
    func initData() {
        var array = ["张三","李四","王五","张老头"]
        // 提示：数据不是批量生成的，而是一条一条依次添加到数据库中的
        for i in 0 ... 49 {
            var str = array[Int(arc4random_uniform(4))]
            var name = NSString(format: "%@%d", str,arc4random_uniform(1000))
            var phoneNo = NSString(format: "1390%05d",arc4random_uniform(100000))
            var person = Person.personWithName(name, age: 18 + Int(arc4random_uniform(20)), phoneNo: phoneNo)
            PersonManager.sharedPersonManager().addPerson(person)
        }
    }
    
}
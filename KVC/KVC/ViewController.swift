//
//  ViewController.swift
//  KVC
//
//  Created by bingoogol on 14/10/13.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        kvcDemo1()
        
    }
    
    func kvcDemo1() {
        var person = Person()
        person.name = "name1"
        person.age = 2
        person.card = Card()
        person.card.no = "修改前"
        
        var book1 = Book()
        book1.bookName = "ios1"
        book1.price = 22
        
        var book2 = Book()
        book2.bookName = "ios3"
        book2.price = 32
        
        person.books = [book1,book2]
        
        println(person.valueForKeyPath("books.price"))
        
        
        // 不能用在Int和NSInteger类型上
        person.setValue("name2", forKey: "name")
        person.setValue(5, forKey: "age")
        person.setValue("修改后", forKeyPath: "card.no")
        
        println("person:\n\(person)")
    }
    
}
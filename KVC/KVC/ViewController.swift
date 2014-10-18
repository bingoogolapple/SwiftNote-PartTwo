//
//  ViewController.swift
//  KVC
//
//  Created by bingoogol on 14/10/13.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit
/**
KVC Key value Coding 键值编码


KVO Key value Observer
*/
class ViewController: UIViewController {
    
    var operson:Person!

    override func viewDidLoad() {
        super.viewDidLoad()
        kvoDemo1()
    }
    
    func kvoDemo1() {
        // 不能观察已经释放掉的对象，如果要观察，需要是强引用对象，或者被其他对象强引用的对象
        operson = Person()
        operson.name = "mary"
        // 用户姓名改变时，需要及时的到通知
        // 如果要监听对象属性的变化，除了系统的通知中心之外，我们可以自己注册观察者
        // 注意：观察者模式的性能不好，使用完毕后，一定记住释放观察者
        
        // 1.观察者对象，可以是自定义对象，也可以是self
        // 2.观察对象的键值路径
        // 3.观察数值变化情况选项（只观察新变化的值，变化之前的数值）
        // 4.上下文，指定观察者的同时，可以通过context设置字符串参数提示
        operson.addObserver(self, forKeyPath: "name", options: NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old, context: nil)
        //点语法不会被观察到
        //operson.name = "mike"
        operson.setValue("mike", forKey: "name")
        operson.removeObserver(self, forKeyPath: "name")
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<Void>) {
        println("\(keyPath)  \n \(object)  \n \(change)  \n \(context)")
    }
    
    func kvcDemo2() {
        var path = NSBundle.mainBundle().pathForResource("Person", ofType: "plist")
        var array = NSArray(contentsOfFile: path!) as NSArray!
        var arrayM = NSMutableArray(capacity: array.count)
        for dict in array {
            var person = Person()
            person.setValuesForKeysWithDictionary(dict as NSDictionary)
            arrayM.addObject(person)
        }
        println(arrayM.valueForKeyPath("books.bookName"))
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
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
    // SQLite数据库的连接，基于该连接可以进行数据库操作
    var handle:COpaquePointer = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.创建（连接）数据库
        self.openDB()
        
        //self.initData()
        
        self.allPersons()
    }
    
    func initData() {
        // 2.创建数据表
        self.createTable()
        // 3.数据操作
        var array = ["张三","李四","王五","张老头"]
        // 提示：数据不是批量生成的，而是一条一条依次添加到数据库中的
        for i in 0 ... 49 {
            var str = array[Int(arc4random_uniform(4))]
            var name = NSString(format: "%@%d", str,arc4random_uniform(1000))
            var phoneNo = NSString(format: "1390%05d",arc4random_uniform(100000))
            self.addPersonWidthName(name, age: 18 + Int(arc4random_uniform(20)), phoneNo: phoneNo)
        }
    }

    /**
    打开数据库
    */
    func openDB() {
        // 生成存放在沙盒中的数据库完整路径
        var docDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        println(docDir)
        var dbName = docDir.stringByAppendingPathComponent("my.db") as NSString

        // 如果数据库不存在，则新建并打开一个数据库，否则直接打开
        if SQLITE_OK == sqlite3_open(dbName.UTF8String, &handle) {
            println("创建/打开数据库成功")
        } else {
            println("创建/打开数据库失败")
        }
    }
    
    /**
    创建数据表
    */
    func createTable() {
        var sql:NSString = "create table if not exists t_person(id integer primary key autoincrement,name text,age integer,phoneNo text)"
        self.execSql(sql, msg: "创建个人记录表")
    }
    
    /**
    添加个人记录
    
    :param: name    姓名那个
    :param: age     年龄
    :param: phoneNo 电话
    */
    func addPersonWidthName(name:NSString,age:NSInteger,phoneNo:NSString) {
        // 注意：添加引号
        var sql = NSString(format: "insert into t_person (name,age,phoneNo) values('%@',%d,'%@')", name,age,phoneNo)
        self.execSql(sql, msg: "添加个人记录")
    }
    
    /**
    执行单步sql语句
    
    :param: sql sql语句
    :param: msg 提示信息
    */
    func execSql(sql:NSString,msg:NSString) {
        var err:UnsafeMutablePointer<Int8> = nil
        if SQLITE_OK == sqlite3_exec(handle, sql.UTF8String, nil,nil,&err) {
            println("\(msg)成功")
        } else {
            println("\(msg)失败:\(NSString(UTF8String: err)!)")
        }
    }
    
    func allPersons() {
        // 查询排序：ASC 升序（默认的排序方法），DESC 降序。由左至右排序的优先级依次降低，也就是第一个排序列的优先级是最高的
        // 按年龄递增，id递减
        var sql:NSString = "SELECT id,name,age,phoneNo FROM t_person ORDER BY age ASC,id DESC"
        // 1.评估准备sql语句是否正确
        var stmt:COpaquePointer = nil
        if SQLITE_OK == sqlite3_prepare_v2(handle, sql.UTF8String, -1, &stmt, nil) {
            println("ok")
            // 2.如果能够正常查询，调用单步执行方法，依次取得查询结果
            // 如果得到一行记录
            while SQLITE_ROW == sqlite3_step(stmt) {
                // 3.获取/显示查询结果
                // sqlite3_column_xxx方法的第二个参数与sql语句中的字段顺序一一对应（从0开始）
                var id = sqlite3_column_int(stmt, 0)
                var name =  sqlite3_column_text(stmt, 1)
                var age =  sqlite3_column_int(stmt, 2)
                var phoneNo =  sqlite3_column_text(stmt, 3)
                
                let utfName = String.fromCString(UnsafePointer<CChar>(name))!
                let utfPhoneNo = String.fromCString(UnsafePointer<CChar>(phoneNo))!
                
                NSLog("id:%d  name:%@  age:%d  phoneNo:%@", id,utfName,age,utfPhoneNo)
            }
        } else {
            println("sql语法错误")
        }
        
        
        // 4.释放句柄
        sqlite3_finalize(stmt)
    }
}
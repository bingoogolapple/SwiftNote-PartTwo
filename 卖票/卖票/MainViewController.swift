//
//  MainViewController.swift
//  卖票
//
//  Created by bingoogol on 14/9/18.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var textView:UITextView!
    var queue:NSOperationQueue!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView(frame:self.view.bounds)
        textView.editable = false
        self.view.addSubview(textView)
        // 预设可卖30张票
        Ticket.sharedTicket().tickets = 30
        //gcdSales()
        
        self.queue = NSOperationQueue()
        opreationSales()
        
       // threadSales()
        
//        var t1 = Ticket.shared
//        t1.tickets = 100
//        var t2 = Ticket.sharedTicket()
//        println("\(t2.tickets)")
//        t2.tickets = 200
//        println("\(t1.tickets)")
    }
    
    func appendContent(text:NSString) {
        var str:NSMutableString = NSMutableString(string: self.textView.text)
        str.appendString("\(text)\n")
        self.textView.text = str
        var range = NSMakeRange(str.length - 1, 1)
        self.textView.scrollRangeToVisible(range)
    }
    
    
    //////////////////////////////////////GCD卖票////////////////////////////////////
    func gcdSales() {
        var queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        // 2)创建两个异步任务分别卖票
        //        dispatch_async(queue, {
        //          self.gcdSaleTicketWithName("gcd-1")
        //        })
        //        dispatch_async(queue, {
        //            self.gcdSaleTicketWithName("gcd-2")
        //        })
        //        dispatch_async(queue, {
        //            self.gcdSaleTicketWithName("gcd-3")
        //        })
        
        // gcd中可以将一组相关联的操作，定义到一个群组中，定义到群组中之后，当多有的线程完成时，可以获得通知
        var group: dispatch_group_t = dispatch_group_create()
        dispatch_group_async(group, queue, {
            self.gcdSaleTicketWithName("gcd-1")
        })
        dispatch_group_async(group, queue, {
            self.gcdSaleTicketWithName("gcd-2")
        })
//        dispatch_group_notify(group, queue, {
//            println("票卖完了")
//        })
        
        dispatch_group_notify(group, dispatch_get_main_queue(), {
            println("票卖完了")
        })
        // 在oc中不加下面这一句也能执行notify
        dispatch_group_leave(group)
    }

    func gcdSaleTicketWithName(name:NSString) {
        while true {
            // 同步锁synchronized要锁的范围，对被抢夺资源修改/读取的代码部分
            objc_sync_enter(Ticket.shared)
            if Ticket.shared.tickets > 0 {
                Ticket.shared.tickets--
                // 提示：涉及到被抢夺资源的内容定义方面的操作，千万不要跨线程去处理
                var str = "剩余票数：\(Ticket.shared.tickets)，线程名称：\(name)"
                // 更新界面
                dispatch_sync(dispatch_get_main_queue(), {
                    self.appendContent(str)
                })
            } else {
                break
            }
            objc_sync_exit(Ticket.shared)
            
            // 模拟线程休眠
            if name.isEqualToString("gcd-1") {
                NSThread.sleepForTimeInterval(0.2)
            } else {
                NSThread.sleepForTimeInterval(0.5)
            }
        }
    }
    ////////////////////////////////////NSOPeration卖票////////////////////////////////////
    func opreationSales() {
        // 提示：opreation中没有群组任务完成通知功能
        // operation可以控制并发数量
        self.queue.addOperationWithBlock({
            self.operationSaleTicketWithName("op-1")
        })
        self.queue.addOperationWithBlock({
            self.operationSaleTicketWithName("op-2")
        })
    }
    
    func operationSaleTicketWithName(name:NSString) {
        while true {
            objc_sync_enter(Ticket.shared)
            if Ticket.shared.tickets > 0 {
                Ticket.shared.tickets--
                // 提示：涉及到被抢夺资源的内容定义方面的操作，千万不要跨线程去处理
                var str = "剩余票数：\(Ticket.shared.tickets)，线程名称：\(name)"
                // 更新界面
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.appendContent(str)
                })
            } else {
                break
            }
            objc_sync_exit(Ticket.shared)
            
            // 模拟线程休眠
            if name.isEqualToString("op-1") {
                NSThread.sleepForTimeInterval(0.2)
            } else {
                NSThread.sleepForTimeInterval(0.5)
            }

        }
    }
    
    ////////////////////////////////////NSThread卖票////////////////////////////////////
    func threadSales() {
        NSThread.detachNewThreadSelector(Selector("threadSaleTicketWithName:"), toTarget: self, withObject: "thread-1")
        NSThread.detachNewThreadSelector(Selector("threadSaleTicketWithName:"), toTarget: self, withObject: "thread-2")
    }
    
    func threadSaleTicketWithName(name:NSString) {
        // 在使用NSThread时，线程调用的方法千万要使用autoreleasepool
        autoreleasepool({
            while true {
                objc_sync_enter(Ticket.shared)
                if Ticket.shared.tickets > 0 {
                    Ticket.shared.tickets--
                    var str = "剩余票数：\(Ticket.shared.tickets)，线程名称：\(name)"
                    // 更新界面
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        self.appendContent(str)
                    })
                    
                } else {
                    break
                }
                objc_sync_exit(Ticket.shared)
                
                // 模拟线程休眠
                if name.isEqualToString("thread-1") {
                    NSThread.sleepForTimeInterval(0.2)
                } else {
                    NSThread.sleepForTimeInterval(0.5)
                }
            }
        })
    }
}
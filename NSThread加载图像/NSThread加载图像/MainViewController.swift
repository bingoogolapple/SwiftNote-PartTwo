//
//  MainViewController.swift
//  NSThread加载图像
//
//  Created by bingoogol on 14/9/18.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit
/*
NSThread
优点：简单
缺点：控制线程的生命周期比较困难，控制并发线程数，先后顺序困难
*/
class MainViewController: UIViewController {
    var imageViewSet:NSSet!
    var queue:NSOperationQueue!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // 实例化操作队列
        self.queue = NSOperationQueue()
    }
    
    func setupUI() {
        var imageViewSet = NSMutableSet(capacity: 28)
        // 一共17张图片，每行显示4张，一共显示7行
        var w = 640 / 8
        var h = 400 / 8
        for row in 0 ... 6 {
            for col in 0 ... 3 {
                var x = CGFloat(col * w)
                var y = CGFloat(row * h)
                var imageView = UIImageView(frame: CGRectMake(x, y, CGFloat(w), CGFloat(h)))
                // 顺序填充图像
                var num = (row * 4 + col) % 17 + 1
                if num < 10 {
                    imageView.image = UIImage(named: "NatGeo0\(num).png")
                } else {
                    imageView.image = UIImage(named: "NatGeo\(num).png")
                }
                self.view.addSubview(imageView)
                imageViewSet.addObject(imageView)
            }
        }
        self.imageViewSet = imageViewSet
        
        // 添加按钮
        var button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(110, 390, 100, 40)
        button.setTitle("刷新图片", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("click"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        println("setupUI  当前线程为\(NSThread.currentThread())")
    }
    
    func click() {
        println("click me")
       //threadLoad()
        //invocationOperationLoad()
    //blockOpreationLoad()
        operationLoad()
        //operationDemo()
        
      gcdLoad()
        //gcdDemo()
    }
    
    func threadLoad() {
        for imageView in imageViewSet {
            // 类方法，直接新建线程调用threadLoadImage
            NSThread.detachNewThreadSelector(Selector("threadLoadImage:"), toTarget: self, withObject: imageView)
            
            // var thread = NSThread(target: self, selector: Selector("threadLoadImage:"), object: imageView)
            // thread.start()
        }
    }
    
    func threadLoadImage(imageView:UIImageView) {
        autoreleasepool{
            NSLog("threadLoadImage  当前线程为\(NSThread.currentThread())")
            // println("threadLoadImage  当前线程为\(NSThread.currentThread())")
            NSThread.sleepForTimeInterval(1)
            
            var num = arc4random_uniform(17) + 1
            var image:UIImage
            if num < 10 {
                image = UIImage(named: "NatGeo0\(num).png")
            } else {
                image = UIImage(named: "NatGeo\(num).png")
            }
            // 在主线程队列上更新UI
            NSOperationQueue.mainQueue().addOperationWithBlock({
                imageView.image = image
            })

        }
    }
    
    func invocationOperationLoad() {
        // 队列可以设置同事并发线程的数量
        self.queue.maxConcurrentOperationCount = 2
        for imageView in imageViewSet {
            var invocationOperation = NSInvocationOperation(target: self, selector: Selector("operationLoadImage:"), object: imageView)
            // 如果直接调用opreation的start方法，是在主线程队列上运行的，不会开启新的线程
            // operation.start()
            
            // Invocation添加到队列，一添加到队列，就会开启新的线程执行任务
            self.queue.addOperation(invocationOperation)
        }
    }
    
    func blockOpreationLoad() {
        for imageView in imageViewSet {
            // 这种实现方式可以传多个参数
            var blockOperation = NSBlockOperation({
                self.operationLoadImage(imageView as UIImageView)
            })
            self.queue.addOperation(blockOperation)
        }
    }
    
    func operationLoad() {
        for imageView in imageViewSet {
            // 这种实现方式可以传多个参数
            self.queue.addOperationWithBlock({
                self.operationLoadImage(imageView as UIImageView)
            })
        }
    }
    
    func operationLoadImage(imageView:UIImageView) {
        NSLog("threadLoadImage  当前线程为\(NSThread.currentThread())")
       // println("threadLoadImage  当前线程为\(NSThread.currentThread())")
        NSThread.sleepForTimeInterval(1)
        
        var num = arc4random_uniform(17) + 1
        var image:UIImage
        if num < 10 {
            image = UIImage(named: "NatGeo0\(num).png")
        } else {
            image = UIImage(named: "NatGeo\(num).png")
        }
        // 在主线程队列上更新UI
        NSOperationQueue.mainQueue().addOperationWithBlock({
            imageView.image = image
        })
    }
    
    // NSOpreation操作之间的顺序
    func operationDemo() {
        var op1 = NSBlockOperation({
            NSLog("下载\(NSThread.currentThread())")
        })
        var op2 = NSBlockOperation({
            NSLog("美化\(NSThread.currentThread())")
        })
        var op3 = NSBlockOperation({
            NSLog("更新\(NSThread.currentThread())")
        })
        // 依赖关系可以多重依赖
        op2.addDependency(op1)
        op3.addDependency(op2)
        // 注意：不要建立循环依赖,加上下面这一句后系统不会报错，但是会不工作
        // op1.addDependency(op3)
        self.queue.addOperation(op1)
        self.queue.addOperation(op3)
        self.queue.addOperation(op2)
        //self.queue.addOperationWithBlock({
        // 这样也是在子线程中执行的
        //            NSLog("完成\(NSThread.currentThread())")
        //         })
    }
    
    func gcdLoad() {
        /*
        1.全局队列（可能会开启多条线程）：所有任务是并发（异步）执行的
        2.串行队列(只会开启一条线程)
        3.主队列：主线程队列
        
        在gcd中，同步还是异步取决于任务执行所在的队列，跟方法名没有关系(全局队列中才分async和sync)
        */
        // 派发dispatch
        // 异步async，并发执行
        
        // 1）获取全局队列，全局调度队列是由系统负责的，开发时不用考虑并发线程数量问题
       var que = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        for imageView in imageViewSet {
            // 2）在全局队列上异步调用方法，加载并更新图像
            dispatch_async(que, {
                NSLog("GCD-\(NSThread.currentThread())")
                var num = arc4random_uniform(17) + 1
                var image:UIImage
                // 通常此处的image是从网络上获取的
                if num < 10 {
                    image = UIImage(named: "NatGeo0\(num).png")
                } else {
                    image = UIImage(named: "NatGeo\(num).png")
                }
                // 3）在主线程队列中，调用同步方法设置UI
                dispatch_sync(dispatch_get_main_queue(), {
                    (imageView as UIImageView).image = image
                })
            })
            
        }
    }
    
    // 3.串行队列
    func gcdDemo() {
        // sync卡死，async永远都是 线程主线程 任务1-》任务2-》任务3
        // var que = dispatch_get_main_queue()
        // sync永远都是 线程主线程 任务1-》任务2-》任务3，async 多个线程 乱序
        // var que = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        // 1)串行队列需要创建
        // 队列名称可以随意
        // sync永远都是 线程主线程 任务1-》任务2-》任务3,async永远都是 任务1-》任务2-》任务3 点击多次时，可能有多个线程，但是每一次点击的所有任务都是在同一个线程中执行
        var que = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL)
        // 2)在队列中执行异步任务
        async(que)
    }
    
    
    func sync(que:dispatch_queue_t) {
        dispatch_sync(que, {
            NSLog("任务1-\(NSThread.currentThread())")
        })
        dispatch_sync(que, {
            NSLog("任务2-\(NSThread.currentThread())")
        })
        dispatch_sync(que, {
            NSLog("任务3-\(NSThread.currentThread())")
        })
    }
    
    func async(que:dispatch_queue_t) {
        dispatch_async(que, {
            NSLog("任务1-\(NSThread.currentThread())")
        })
        dispatch_async(que, {
            NSLog("任务2-\(NSThread.currentThread())")
        })
        dispatch_async(que, {
            NSLog("任务3-\(NSThread.currentThread())")
        })
    }
}
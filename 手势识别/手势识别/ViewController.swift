//
//  ViewController.swift
//  手势识别
//
//  Created by bingoogol on 14/9/24.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

/*
手势使用的步骤
1.实例化手势
2.指定手势参数
3.将手势添加到指定视图
4.编写手势监听方法
提示：UIImageView默认是不支持用户交互的

UIGestureRecognizer是一个抽象类，六种手势识别都继承自UIGestureRecognizer，但是UIGestureRecognizer不能直接实例化
*/
class ViewController: UIViewController {
    var imageView:UIImageView!
    let kImageInitFrame = CGRectMake(40, 200, 300, 196)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
        imageView = UIImageView(image: UIImage(named: "001.jpg"))
        imageView.frame = kImageInitFrame
        // UIImageView默认是不支持用户交互的
        imageView.userInteractionEnabled = true
        self.view.addSubview(imageView)
        
        // 1.点按手势
        var tap = UITapGestureRecognizer(target: self, action: "tap:")
        // 点按次数，例如双击2
        // 注意：在iOS中最好少用双击，如果一定要用，就一定要有一个图形化的界面告知用户可以双击
        tap.numberOfTapsRequired = 2
        // 用几根手指点按
        tap.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tap)
        
        // 2.长按手势
        var longTap = UILongPressGestureRecognizer(target: self, action: "longTap:")
        imageView.addGestureRecognizer(longTap)
        
        // 3.拖动手势
        var pan = UIPanGestureRecognizer(target: self, action: "pan:")
        imageView.addGestureRecognizer(pan)
        
        // 4.旋转手势
        var rotation = UIRotationGestureRecognizer(target: self, action: "rotation:")
        imageView.addGestureRecognizer(rotation)
        
        // 5.缩放（捏合）手势
        var pinch = UIPinchGestureRecognizer(target: self, action: "pinch:")
        imageView.addGestureRecognizer(pinch)
        
        // 6.轻扫手势
        /*
        手指在屏幕上扫动和拖动手势的区别在于手指离开屏幕还会触发监听方法
        手指可以上下左右四个方向轻轻扫动，如果没有指定方向默认都是向右扫动
        如果要使用多个方向的轻扫手势，需要指定多个轻扫手势
        
        通常只需指定左右两个方向即可。因为iOS用户大多不习惯上下的轻扫动作
        注意：在设置轻扫手势时，通常需要将手势识别添加到父视图上监听。在监听方法中，注意不要使用recognizer.view，因为手势监听的是父视图，而要处理的视图通常是其他的视图
        */
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func tap(recognizer:UITapGestureRecognizer) {
        println("点我了")
        // 做一个动画效果，向下移除屏幕，完成后再重新返回初始位置
        // recognizer.view就是识别到手势的视图，也就是手势绑定到的视图
        var initFrame = recognizer.view?.frame
        var targetFrame = recognizer.view?.frame
        targetFrame?.origin.y += 300
        
        // 方式一
//        UIView.animateWithDuration(1, animations: {
//                recognizer.view!.frame = targetFrame!
//            }, completion: {(finished:Bool) in
//                UIView.animateWithDuration(1, animations: {
//                    recognizer.view!.frame = initFrame!
//                })
//            }
//        )
        
        // 方式二
//        UIView.animateWithDuration(1, animations: {
//                UIView.setAnimationRepeatAutoreverses(true)
//                recognizer.view!.frame = targetFrame!
//            }, completion: {(finished:Bool) in
//                recognizer.view!.frame = initFrame!
//            }
//
//        )

        
        UIView.animateWithDuration(1, animations: {
                UIView.setAnimationRepeatAutoreverses(true)
                UIView.setAnimationRepeatCount(2)
                recognizer.view!.frame = targetFrame!
            }, completion: {(finished:Bool) in
                recognizer.view!.frame = initFrame!
            }
            
        )
    }
    
    func longTap(recognizer:UILongPressGestureRecognizer) {
        /*
        旋转半圈动画，动画完成后恢复
        长按手势属于连续手势，是需要处理状态
        因为长按通常只有一根手指，因此在began状态下，长按手势就已经被识别了
        针对长按的处理，最好放在Began状态中实现
        */
        if UIGestureRecognizerState.Began == recognizer.state {
            
        } else if UIGestureRecognizerState.Ended == recognizer.state {
            println("长按")
            UIView .animateWithDuration(1, animations: {
                recognizer.view!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                }, completion: {(finished:Bool) in
                    // CGAffineTransformIdentity将视图的形变复原（平移、缩放、旋转）
                    recognizer.view!.transform = CGAffineTransformIdentity
                }
            )
        }
        
    }
    
    func pan(recognizer:UIPanGestureRecognizer) {
        println("拖动")
        // 在手势变化时处理图片的移动。Changed状态类似于touchesMoved方法，会不断地被调用
        if UIGestureRecognizerState.Changed == recognizer.state {
            //            var location = recognizer.locationInView(self.view)
            //            recognizer.view?.center = location
            
            
            // 判断在父视图中平移的位置，平移的偏移量始终以视图的初始位置为基础
            var deltaP = recognizer.translationInView(self.view)
            
            // 方法二
//            var targetRect = kImageInitFrame
//            targetRect.origin.x += deltaP.x
//            targetRect.origin.y += deltaP.y
//            recognizer.view?.frame = targetRect
            
            // 方法三：用形变参数来改变图像的位置
            recognizer.view?.transform = CGAffineTransformMakeTranslation(deltaP.x, deltaP.y)
            

        } else if UIGestureRecognizerState.Ended == recognizer.state {
            // 拖动结束后，以动画的方式回到初始位置
            UIView.animateWithDuration(0.5, animations: {
                // 配合方法二用
                //recognizer.view!.frame = self.kImageInitFrame
                // 配合方法三用
                recognizer.view!.transform = CGAffineTransformIdentity
            })
        }
    }
    
    func rotation(recognizer:UIRotationGestureRecognizer) {
        /*
        rotation是基于图片的初始旋转弧度的
        目的：
            变化过程中：旋转
            结束后：恢复
        */
        if UIGestureRecognizerState.Changed == recognizer.state {
            
            
//            // 累加的形变
//            recognizer.view?.transform = CGAffineTransformRotate(recognizer.view!.transform, recognizer.rotation)
//            // 把手势识别的rotation设置为0，在下一次触发时，以当前的旋转角度为基准继续旋转
//            recognizer.rotation = 0
            
            recognizer.view?.transform = CGAffineTransformMakeRotation(recognizer.rotation)
        } else if UIGestureRecognizerState.Ended == recognizer.state {
            UIView.animateWithDuration(0.5, animations: {
                // CGAffineTransformIdentity将视图的形变复原（平移、缩放、旋转）
                recognizer.view!.transform = CGAffineTransformIdentity
            })
        }
    }
    
    func pinch(recognizer:UIPinchGestureRecognizer) {
        /*
        变化过程中，放大缩小
        结束后，恢复
        */
        if UIGestureRecognizerState.Changed == recognizer.state {
            recognizer.view!.transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale)
        } else {
            UIView.animateWithDuration(0.5, animations: {
                // CGAffineTransformIdentity将视图的形变复原（平移、缩放、旋转）
                recognizer.view!.transform = CGAffineTransformIdentity
            })
        }
    }
    
    // 尽管轻扫手势也是连续手势，但是该手势是载手指离开屏幕才会被触发的，因此载编写代码时，不需要处理手势的状态
    func swipe(recognizer:UISwipeGestureRecognizer) {
        // 让图片手指不同的方向飞出屏幕，然后再复位
        var frame = kImageInitFrame
        if UISwipeGestureRecognizerDirection.Up == recognizer.direction {
            frame.origin.y -= 400
        } else if UISwipeGestureRecognizerDirection.Down == recognizer.direction {
            frame.origin.y += 400
        } else if UISwipeGestureRecognizerDirection.Left == recognizer.direction {
            frame.origin.x -= 300
        } else {
            frame.origin.x += 300
        }
        UIView.animateWithDuration(1, animations: {
                self.imageView.frame = frame
            }, completion: {(finished:Bool) in
                UIView.animateWithDuration(1.0, animations: {
                    self.imageView.frame = self.kImageInitFrame
                })

            }
        )
    }

}


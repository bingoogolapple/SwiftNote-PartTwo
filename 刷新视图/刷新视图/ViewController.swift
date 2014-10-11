//
//  ViewController.swift
//  刷新视图
//
//  Created by bingoogol on 14/10/11.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    var myView:MyView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView = MyView(frame: CGRectMake(0, 20, 320, 200))
        self.view.addSubview(myView)
        
        var textField = UITextField(frame: CGRectMake(20, 240, 280, 30))
        textField.borderStyle = UITextBorderStyle.Line
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        textField.delegate = self
        self.view.addSubview(textField)
        
        var slider = UISlider(frame: CGRectMake(20, 300, 280, 20))
        slider.minimumValue = 10
        slider.maximumValue = 40
        slider.value = 20
        slider.addTarget(self, action: Selector("sliderValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(slider)
    }
    
    func sliderValueChanged(slider:UISlider) {
        self.myView.setFontSize(CGFloat(slider.value))
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.myView.setText(textField.text)
        return true
    }

}
//
//  Model.swift
//  XML和JSON
//
//  Created by bingoogol on 14/10/7.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

/*
异步加载网络图像的内存缓存解决方法
1.在对象中定义一个UIImage
2.在控制器中，填充表格时，判断UIImage是否存在内容
    1）不存在显示占位图像，同时开启异步网络连接加载网络图像，网络图像加载完成后，设置对象的cacheImage，设置完成后，刷新表格对应的行
    2）如果cacheImage存在，直接显示cacheImage

在开发网络应用中，数据是同步加载的，图像、音频、视频是异步加载的。保证在不阻塞主线程使用的前提下，用户能够渐渐地看到多媒体信息
*/
class Model: NSObject {
    var cacheImage:UIImage!
    var videoId:Int!
    var name:NSString!
    var length:Int!
}
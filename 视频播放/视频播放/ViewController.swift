//
//  ViewController.swift
//  视频播放
//
//  Created by bingoogol on 14/10/10.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    var moviePlayer : MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    
    func playVideo() {
        var url = NSBundle.mainBundle().URLForResource("video", withExtension: "mp4")
        moviePlayer = MPMoviePlayerController(contentURL: url)
        // 播放器的大小 16:9
        moviePlayer.view.frame = CGRectMake(0, 20, 320, 180)
        self.view.addSubview(moviePlayer.view)
        moviePlayer.play()
    }

}
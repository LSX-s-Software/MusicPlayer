//
//  ViewController.swift
//  player1
//
//  Created by 朱俊泽 on 2020/3/21.
//  Copyright © 2020 朱俊泽. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var blurImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var controlView: UIVisualEffectView!
    
    var isPlayed:Bool = false
    var audioPlayer:AVPlayer?
    var playerItem:AVPlayerItem?
    var listShown = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playImageView.layer.opacity = 0
        itemImageView.layer.cornerRadius = 100
        //旋转
        rotationAnimation(theView: itemImageView, direction: true)
        rotationAnimation(theView: playImageView, direction: false)
        //模糊
        blurEffect(theView: blurImageView)
        
        //设置音频
        audioPlayer = AVPlayer()
        let url:URL = Bundle.main.url(forResource: "1", withExtension: "mp3")!
        playerItem = AVPlayerItem(url: url)
        audioPlayer?.replaceCurrentItem(with: playerItem)
        
    }
    
    @IBAction func playOrPause(_ sender: Any) {
        if isPlayed {
            audioPlayer?.pause()
            self.playButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            //透明度改变
            opacityAnimation(theView: playImageView, direction: true)
            //缩放
            scaleAnimation(theView: animationImageView)
            playImageView.layer.opacity = 0
            
        }
        else{
            audioPlayer?.play()
            self.playButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            opacityAnimation(theView: playImageView, direction: false)
            scaleAnimation(theView: animationImageView)
            playImageView.layer.opacity = 1
        }
        isPlayed.toggle()
    }
    
    @IBAction func showList(_ sender: Any) {
        let frame = tableView1.frame
        if listShown {
//            tableView1.frame = CGRect(x: frame.minX, y: view.frame.maxY, width: frame.width, height: frame.height)
            hideAnimation(theView: tableView1, toValue: [frame.minX, view.frame.maxY])
        } else {
//            tableView1.frame = CGRect(x: frame.minX, y: controlView.frame.minY - frame.height, width: frame.width, height: frame.height)
            hideAnimation(theView: tableView1, toValue: [frame.minX, controlView.frame.minY - frame.height])
        }
        listShown = !listShown
    }
    
}


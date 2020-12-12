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
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var loadTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    var isPlayed:Bool = false
    var audioPlayer:AVPlayer?
    var playerItem:AVPlayerItem?
    var listShown = true
    var totalTime:Float64?
    var loadTime:Float64?
    
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
        
        totalTime = CMTimeGetSeconds((self.audioPlayer?.currentItem!.duration)!)
        
          self.audioPlayer?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self](time) in
             //当前正在播放的时间
             self!.loadTime = CMTimeGetSeconds(time)
             //总时间
             self!.totalTime = CMTimeGetSeconds((self?.audioPlayer?.currentItem?.duration)!)
             //播放进度设置
             self?.slider.value = Float(self!.loadTime!/self!.totalTime!)
             //播放的时间
            self!.updataTime()
         }
        
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
    
    @IBAction func sliderAction(_ sender: Any) {
        let rate = self.slider.value
        self.loadTime = Float64(rate)
    }
}

//处理时间
extension ViewController{
    
    //转换格式
    func changeTimeFormat(timeInterval:Float64)->String{
        let time = Int(timeInterval)
        let m = time/60
        let s = time%60
        var mm:String?
        var ss:String?
        if m < 10 {
            mm = "0" + String(m)
        }
        else{
            mm = String(m)
        }
        if s < 10 {
            ss = "0" + String(s)
        }
        else{
            ss = String(s)
        }
        return mm! + ":" + ss!
    }
    
    //更新时间
        func updataTime(){
            if self.loadTime!<1200&&self.totalTime!>1 {
                self.loadTimeLabel.text = self.changeTimeFormat(timeInterval: self.loadTime!)
            //总时间
                self.totalTimeLabel.text = self.changeTimeFormat(timeInterval:CMTimeGetSeconds((self.audioPlayer?.currentItem!.duration)!))
            }
        }
        
    }



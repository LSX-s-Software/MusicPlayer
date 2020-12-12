//
//  animation.swift
//  player1
//
//  Created by 朱俊泽 on 2020/3/21.
//  Copyright © 2020 朱俊泽. All rights reserved.
//

import Foundation
import UIKit

//在主控制器中扩展自定义动画
extension ViewController{
    
    //旋转动画，direction旋转旋转方向
    func rotationAnimation(theView: UIImageView,direction:Bool){
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        if direction {
            animation.toValue = 2*Double.pi
        }
        else{
            animation.toValue = -2*Double.pi
        }
        animation.duration = 16
        animation.repeatCount = HUGE
        animation.autoreverses = false
        theView.layer.add(animation, forKey: "roatationAnimation")
        
    }
    
    func hideAnimation(theView: UIView,toValue: Array<Any>){
        let animation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.toValue = toValue
        animation.duration = 0.8
        animation.autoreverses = false
        theView.layer.add(animation, forKey: "hideAnimation")
    }
    
    //模糊效果
    func blurEffect(theView:UIImageView){
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame
        theView.addSubview(blurView)
    }
    
    //透明动画，direction选择显现还是隐藏
    func opacityAnimation(theView:UIImageView,direction:Bool) {
        let animation = CABasicAnimation(keyPath: "opacity")
        
        if direction {
            animation.fromValue = 0
            animation.toValue = 1
            
        }else{
            animation.fromValue = 1
            animation.toValue = 0
        }
        animation.duration = 0.3
        animation.autoreverses = true
        theView.layer.add(animation, forKey: "addLayeranimationOpacity")
        
    }
    
    //2倍缩放动画
    func scaleAnimation(theView:UIImageView) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.3
        animation.repeatCount = 1
        animation.autoreverses = true
        theView.layer.add(animation, forKey: "addLayerAnimationScale")
    }
}

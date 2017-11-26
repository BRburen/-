//
//  GiftDigitLabel.swift
//  礼物通道
//
//  Created by sia on 2017/11/24.
//  Copyright © 2017年 BR_buren1111. All rights reserved.
//  连击

import UIKit

class GiftDigitLabel: UILabel {

    override func drawText(in rect: CGRect) {
        //获取上下文
        let context = UIGraphicsGetCurrentContext()
        
        //2给上下文线段设置一个宽度,通过该宽度话出文本
        context?.setLineWidth(5)
        context?.setLineJoin(.round)    //添加模式 .round 圆角线
        context?.setTextDrawingMode(.stroke)
        textColor = UIColor.orange
        super.drawText(in: rect)
        
        context?.setTextDrawingMode(.fill)
        textColor = UIColor.white
        super.drawText(in: rect)
    }
    func showDigitAnimation( _ complection : @escaping() -> () ){
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
            
            //一 开始时间 ,二 执行时长 0.25的 0.5倍
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            
        }) { (isFinished) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { (inFinished) in
                complection()
            })
        }
        
        /*
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        }) { (inFinished) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }, completion: { (inFinished) in
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: {
                    self.transform = CGAffineTransform.identity
                }, completion: { (inFinished) in
                    complection()
                })
            })
        }
    */
    }
}

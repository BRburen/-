//
//  GiftChannelView.swift
//  礼物通道
//
//  Created by sia on 2017/11/26.
//  Copyright © 2017年 BR_buren1111. All rights reserved.
//

import UIKit




enum GiftChannelViewState {
    case idle   //闲置状态
    case animating  //正在执行动画
    case willEnd    //正在等待
    case endAnimating //正在消失动画
}

class GiftChannelView: UIView {

    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: GiftDigitLabel!
    
    fileprivate var cacheNumber : Int = 0   //缓存 计数
    fileprivate var currentNumber : Int = 0     //当前连击数
    var state : GiftChannelViewState = .idle
    
    /*参数 返回值 */
    /*var complectionCallback : ) -> Void 保证初始化所以是Optional*/
    /*var complectionCallback : ((channel : GiftChannelView) ->Void)? 3.0不能写外部参数*/
    var complectionCallback : ((GiftChannelView) ->Void)?
    
    var giftModel : GiftModel? {
        didSet{
            //1对模型校验
            guard let giftModel = giftModel else { return }
            //2给空间设置 数据
            iconImageView.image = UIImage(named:giftModel.senderURL)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "送出礼物: 【\(giftModel.giftName)】"
            giftImageView.image = UIImage(named : giftModel.giftURL)
            
            //将ChannelView弹出
            state = .animating
            performAnimation()
        }
    }
}



// MARK: - 设置UI
extension GiftChannelView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
}

// MARK: - 动画
extension GiftChannelView {
    // MARK: - 弹出动画
    fileprivate func performAnimation(){
        digitLabel.alpha = 1.0
        digitLabel.text = " x1 "
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.frame.origin.x = 0
        }) { (isFinished) in
            self.performDigitAnimation()
        }
    }
    // MARK: - 连击动画
    fileprivate func performDigitAnimation(){
        currentNumber += 1
        digitLabel.text = " x\(currentNumber) "
        digitLabel.showDigitAnimation {
            
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.performAnimation() //递归调用
            }else{
                self.state = .willEnd
                self.perform(#selector(self.performEndAnimation), with: self, afterDelay: 3)
            }
        }
    }
// MARK: - 消失动画
   @objc fileprivate func performEndAnimation(){
    state = .endAnimating
    UIView.animate(withDuration: 0.25, animations: {
        self.frame.origin.x = UIScreen.main.bounds.width
        self.alpha = 0
    }) { (isFinished) in
        self.giftModel = nil
        self.frame.origin.x = -self.frame.width
        self.state = .idle
        self.currentNumber = 0
        self.cacheNumber = 0
        self.digitLabel.alpha = 0.0
        /*
        //block调用*/
        if let complectionCallback = self.complectionCallback{
            complectionCallback(self)
        }
 
        
    }
    }
}

// MARK: - 对外提供
extension GiftChannelView {
    func addOnceToCache(){
        
        if state == .willEnd{
            performDigitAnimation()
            //取消之前的任务3秒等待
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        }else{
            cacheNumber += 1
        }
    }

    class func loadChannelView() -> GiftChannelView{
        return Bundle.main.loadNibNamed("GiftChannelView", owner: nil, options: nil)?.first as! GiftChannelView
    }
}

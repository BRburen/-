//
//  GiftContainerView.swift
//  礼物通道
//
//  Created by sia on 2017/11/24.
//  Copyright © 2017年 BR_buren1111. All rights reserved.
// 礼物View

import UIKit

private let kChannelCount = 2
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10

class GiftContainerView: UIView {
    
    fileprivate lazy var channelViews : [GiftChannelView] = [GiftChannelView]()
    fileprivate lazy var cacheGiftModels : [GiftModel] = [GiftModel]()   //缓存中的Model
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GiftContainerView{
    fileprivate func setupUI(){
        //1根据当前的取代数,创建ChannelView
        let w : CGFloat = frame.width
        let h : CGFloat = kChannelViewH
        let x : CGFloat = 0
        for i in 0..<kChannelCount {
            let y : CGFloat = (h + kChannelMargin) * CGFloat(i)
            
            let channelView = GiftChannelView.loadChannelView()
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            channelView.alpha = 0.0
            channelView.state = .idle
            //            channelView.delegate = self
            channelViews.append(channelView)
            addSubview(channelView)
            
            
            channelView.complectionCallback = { channelView in
                // 取出缓存中的Model第一个
                guard self.cacheGiftModels.count != 0 else { return }
                let firstGiftModel = self.cacheGiftModels.first!
                self.cacheGiftModels.removeFirst()
                channelView.giftModel = firstGiftModel
                
                // .将数组中剩余有和firstGiftModel相同的模型放入到ChanelView缓存中
                for i in (0..<self.cacheGiftModels.count).reversed() {
                    let giftModel = self.cacheGiftModels[i]
                    if giftModel.isEqual(firstGiftModel) {
                        channelView.addOnceToCache()
                        self.cacheGiftModels.remove(at: i)
                    }
                }
            }
            
            
        }
    }
}

extension GiftContainerView {
    func showGiftModel(_ giftModel : GiftModel){
        
        //1 判断正在ChannelView和赠送的新礼物的名称是否相同 (userName / giftName)
        if let channelView = checkUsingChannelView(giftModel) {
             channelView.addOnceToCache()   //缓存加一
            return
        }
        //2判断有没有闲置的ChannelView ]
        if let channelView = chackIdleChannelView() {
            channelView.giftModel = giftModel   //设置Model
            return
        }
        
        // 将数据放到缓存中
        cacheGiftModels.append(giftModel)
    }
    
    private func checkUsingChannelView(_ giftModel : GiftModel) -> GiftChannelView?{
        for channelView in channelViews{
            if giftModel.isEqual(channelView.giftModel) && channelView.state != .endAnimating{
                return channelView
            }
        }
        return nil
    }
    
    private func chackIdleChannelView() -> GiftChannelView?{
        for channelView in channelViews {
            if channelView.state == .idle {
                return channelView
            }
        }
        return nil
    }
    
}



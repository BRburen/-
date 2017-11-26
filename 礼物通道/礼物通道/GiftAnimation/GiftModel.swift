//
//  GiftModel.swift
//  礼物通道
//
//  Created by sia on 2017/11/26.
//  Copyright © 2017年 BR_buren1111. All rights reserved.
//

import UIKit

class GiftModel: NSObject {
    var senderName : String = ""    // 谁送的礼物 (谁)
    var senderURL : String = ""     //头像 (谁)
    var giftName : String = ""      //礼物名
    var giftURL : String = ""       //礼物URL
    
    init(senderName : String ,senderURL : String ,giftName :String ,giftURL : String) {
        self.senderName = senderName
        self.senderURL = senderURL
        self.giftName = giftName
        self.giftURL = giftURL
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let objec = object as? GiftModel else { return false }
        
        guard objec.giftName == giftName && objec.senderName == senderName else { return false }
        
        return true
    }
}

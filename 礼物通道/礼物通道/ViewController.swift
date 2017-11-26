//
//  ViewController.swift
//  礼物通道
//
//  Created by sia on 2017/11/24.
//  Copyright © 2017年 BR_buren1111. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: GiftDigitLabel!
    
    fileprivate lazy var giftContainerView : GiftContainerView = GiftContainerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        giftContainerView.frame = CGRect(x: 0, y: 100, width: 250, height: 90)
        giftContainerView.backgroundColor = UIColor.lightGray
        view.addSubview(giftContainerView)
    }
    @IBAction func gift1(_ sender: UIButton) {
        let gift1 = GiftModel(senderName: "coderwhy", senderURL: "icon4", giftName: "火箭", giftURL: "prop_b")
        giftContainerView.showGiftModel(gift1)
    }
    @IBAction func gift2(_ sender: UIButton) {
        let gift2 = GiftModel(senderName: "coder", senderURL: "icon2", giftName: "飞机", giftURL: "prop_f")
        giftContainerView.showGiftModel(gift2)
    }
    @IBAction func gift3(_ sender: UIButton) {
        let gift3 = GiftModel(senderName: "why", senderURL: "icon3", giftName: "红包", giftURL: "prop_h")
        giftContainerView.showGiftModel(gift3)
    }
    
    @IBAction func gift4(_ sender: UIButton) {
        let gift3 = GiftModel(senderName: "why1", senderURL: "icon4", giftName: "娃娃1", giftURL: "icon2")
        giftContainerView.showGiftModel(gift3)
    }
    
    @IBAction func gift5(_ sender: UIButton) {
        let gift3 = GiftModel(senderName: "why2", senderURL: "icon5", giftName: "娃娃2", giftURL: "icon1")
        giftContainerView.showGiftModel(gift3)
    }
}


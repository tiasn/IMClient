//
//  ViewController.swift
//  IMClient
//
//  Created by LTX on 2017/5/10.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate lazy var txSocket : TXSocket = TXSocket(address: "192.168.2.54", port: 8585)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userinfo = UserInfo.Builder()
        userinfo.name = "刘苏豆子";
        userinfo.icon = "dz.png"
        userinfo.level = 100
        
        //获取data
        guard let user = try? userinfo.build() else{ return }
        let data = user.data()
        // 发送data
        txSocket.tcpClient.send(data: data)
        
        
        
        let chatMsg = ChatMessage.Builder()
        chatMsg.user = user
        chatMsg.chatText = "哈哈哈哈"
        
        
        let giftMsg = GiftMessage.Builder()
        giftMsg.user = user
        giftMsg.giftName = "火箭"
        giftMsg.giftIcon = "hj.png"
        giftMsg.giftCount = 1
        
        
        
        
        
        
        
        
        //解析
        guard let userInfo = try? UserInfo.parseFrom(data: data) else {
            return
        }
        
        print(userInfo.name)
        print(userInfo.icon)
        print(userInfo.level)
        
        
        
        if txSocket.connectServer() {
            print("连接成功。。。")
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        txSocket .sendMsg("Hello,World!")
    }

}



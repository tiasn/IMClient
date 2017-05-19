//
//  TXSocket.swift
//  IMClient
//
//  Created by LTX on 2017/5/10.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

//消息类型
enum MessageType : Int {
    
    case enterRoom = 0
    case leaveRoom = 1
    case chatMessage = 2
    case giftMessage = 3
}

class TXSocket {
    
    var tcpClient : TCPClient
    
    
    fileprivate lazy var userInfo : UserInfo.Builder = {
        let userInfo = UserInfo.Builder()
        userInfo.name = "主播"
        userInfo.level = 23
        userInfo.icon = "123.png"
        
        return userInfo
        
    }()
    
    init(address : String, port : Int32) {
        tcpClient = TCPClient(address: address, port: port)
    }
}


extension TXSocket {

    // 连接服务器
    func connectServer() -> Bool {
        
        return tcpClient.connect(timeout: 5).isSuccess
    }
    
//进入房间 获取用户信息 并发送用户信息
    func enterRoom() {
        
        let userData = (try! userInfo.build()).data()
        
        sendMsg(type: .enterRoom, msgData: userData)
    
        
    }
    
    
//离开房间
    func leaveRoom() {
        let userData = (try! userInfo.build()).data()
        
        sendMsg(type: .leaveRoom, msgData: userData)
        
    }
    
    
//发送文本消息
    func sendTextMsg(messageText : String) {
        
        let chatMsg = ChatMessage.Builder()
        chatMsg.user = try! userInfo.build()
        chatMsg.chatText = messageText
        
        let chatData = (try! chatMsg.build()).data()

        sendMsg(type: .chatMessage, msgData: chatData)
    }
    
    
// 发送礼物消息
    func sendGiftMsg(_ giftName : String, _ giftURL : String, _ giftGifURL : String, _ giftCount : Int) {
        
        let giftMsg = GiftMessage.Builder()
        giftMsg.user = try! userInfo.build()
        giftMsg.giftName = giftName
        giftMsg.giftIcon = giftURL
        giftMsg.giftCount = Int32(giftCount)
        
        let giftData = (try! giftMsg.build()).data()
        
        sendMsg(type: .giftMessage, msgData: giftData)
        
        
    }
    
    
    
    
    
    //发送消息
    func sendMsg(type : MessageType, msgData : Data) {
        //消息长度
        var length = msgData.count
        let lengthData = Data(bytes: &length, count: 4)
        
        //消息类型
        var type = type.rawValue
        let typeData = Data(bytes: &type, count: 2)
        
        
        //发送消息
        tcpClient.send(data: lengthData + typeData + msgData)
        
        
    }

}

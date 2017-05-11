//
//  TXSocket.swift
//  IMClient
//
//  Created by LTX on 2017/5/10.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

class TXSocket {
    
    fileprivate var tcpClient : TCPClient
    
    init(address : String, port : Int32) {
        tcpClient = TCPClient(address: address, port: port)
    }
}


extension TXSocket {

    // 连接服务器
    func connectServer() -> Bool {
        
        return tcpClient.connect(timeout: 5).isSuccess
    }
    
    // 发送消息
    func sendMsg(_ msgString : String) {
        
        //获取消息长度data
        var length = msgString.characters.count
        let lengthData = Data(bytes: &length, count: 4)
        
        //获取真实消息的data
        guard  let msgData = msgString.data(using: .utf8) else{return}
        
        
        tcpClient .send(data: lengthData + msgData)

    }

}

//
//  ViewController.swift
//  IMClient
//
//  Created by LTX on 2017/5/10.
//  Copyright © 2017年 LTX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate lazy var txSocket : TXSocket = TXSocket(address: "192.168.2.26", port: 8585)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if txSocket.connectServer() {
            print("连接成功。。。")
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        txSocket .sendMsg("Hello,World!")
    }

}



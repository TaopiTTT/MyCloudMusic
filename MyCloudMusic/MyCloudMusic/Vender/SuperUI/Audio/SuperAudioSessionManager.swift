//
//  SuperAudioSessionManager.swift
//  音频管理器，主要处理音频焦点获取，释放，音量调整
//
//  Created by Tao on 2025/12/26.
//

import Foundation

//导入系统媒体
import AVFoundation

class SuperAudioSessionManager{
    static func requestAudioFocus() {
        //获取到音频会话
        let session = AVAudioSession.sharedInstance()

        //设置category
        //可以简单理解为：category就是预定好的一些模式
        //playback:可以后台播放；独占；音量可以控制音量
        try! session.setCategory(.playback, mode: .default, options: [])

        //激活音频会话
        try! session.setActive(true, options: [])
    }
}

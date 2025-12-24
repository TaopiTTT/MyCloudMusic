//
//  BaseMusicPlayerController.swift
//  通用音乐播放界面
//
//  Created by Tao on 2025/12/23.
//

import UIKit

class BaseMusicPlayerController: BaseTitleController {

    /// 启动播放界面
    func startMusicPlayerController() {
        //简单播放器界面
        startController(SimplePlayerController.self)
        
        //黑胶唱片播放界面
//        startController(MusicPlayerController.self)
    }
}

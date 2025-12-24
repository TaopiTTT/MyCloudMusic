//
//  SimplePlayerController.swift
//  简单播放界面,用来测试音乐播放相关逻辑
//
//  Created by Tao on 2025/12/23.
//

import UIKit
import TangramKit

class SimplePlayerController: BaseTitleController {
    var startView:UILabel!
    var progressView:UISlider!
    var endView:UILabel!
    var playButtonView:QMUIButton!
    var loopModelButtonView:QMUIButton!
    
    override func initViews() {
        super.initViews()
        initTableViewSafeArea()
        setBackgroundColor(.colorLightWhite)
        
        //进度容器
        let progressContainer = ViewFactoryUtil.orientationContainer()
        progressContainer.tg_gravity = TGGravity.vert.center
        progressContainer.tg_space = PADDING_MEDDLE
        progressContainer.tg_padding = UIEdgeInsets(top: PADDING_MEDDLE, left: PADDING_OUTER, bottom: PADDING_MEDDLE, right: PADDING_OUTER)
        container.addSubview(progressContainer)
        
        startView = UILabel()
        startView.tg_width.equal(.wrap)
        startView.tg_height.equal(.wrap)
        startView.text = "00:00"
        progressContainer.addSubview(startView)
        
        progressView = UISlider()
        progressView.tg_width.equal(.fill)
        progressView.tg_height.equal(.wrap)
        
        progressView.value = 0
        progressContainer.addSubview(progressView)
        
        endView = UILabel()
        endView.tg_width.equal(.wrap)
        endView.tg_height.equal(.wrap)
        endView.text = "00:00"
        progressContainer.addSubview(endView)
        
        //按钮容器
        let controlContainer = ViewFactoryUtil.orientationContainer()
        controlContainer.tg_gravity = TGGravity.vert.center
        controlContainer.tg_padding = UIEdgeInsets(top: PADDING_MEDDLE, left: PADDING_OUTER, bottom: PADDING_MEDDLE, right: PADDING_OUTER)
        container.addSubview(controlContainer)
        
        var buttonView = QMUIButton()
        buttonView.tg_width.equal(.fill)
        buttonView.tg_height.equal(.wrap)
        buttonView.setTitle("上一曲", for: .normal)
        buttonView.addTarget(self, action: #selector(onPreviousClick(_:)), for: .touchUpInside)
        controlContainer.addSubview(buttonView)
        
        playButtonView = QMUIButton()
        playButtonView.tg_width.equal(.fill)
        playButtonView.tg_height.equal(.wrap)
        playButtonView.setTitle("播放", for: .normal)
        playButtonView.addTarget(self, action:#selector(onPlayClick(_:)), for: .touchUpInside)
        controlContainer.addSubview(playButtonView)
        
        buttonView = QMUIButton()
        buttonView.tg_width.equal(.fill)
        buttonView.tg_height.equal(.wrap)
        buttonView.setTitle("下一曲", for: .normal)
        buttonView.addTarget(self, action: #selector(onNextClick(_:)), for: .touchUpInside)
        controlContainer.addSubview(buttonView)
        
        loopModelButtonView = QMUIButton()
        loopModelButtonView.tg_width.equal(.fill)
        loopModelButtonView.tg_height.equal(.wrap)
        loopModelButtonView.setTitle("列表循环", for: .normal)
        loopModelButtonView.addTarget(self, action:#selector(onLoopModelClick(_:)), for: .touchUpInside)
        controlContainer.addSubview(loopModelButtonView)
    }
    
    
    @objc func onPreviousClick(_ sender:QMUIButton) {
//        MusicListManager.shared().play(MusicListManager.shared().previous())
    }
    
    @objc func onPlayClick(_ sender:QMUIButton) {
        playOrPause()
    }
    
    @objc func onNextClick(_ sender:QMUIButton) {
//        MusicListManager.shared().play(MusicListManager.shared().next())
        
    }
    
    @objc func onLoopModelClick(_ sender:QMUIButton) {
//        //更改循环模式
//        MusicListManager.shared().changeLoopModel()
//        
//        //显示循环模式
//        showLoopModel()
    }
    
    /// 播放或暂停
    func playOrPause() {
        if MusicPlayerManager.shared().isPlaying() {
            MusicPlayerManager.shared().pause()
        } else {
            MusicPlayerManager.shared().resume()
        }
    }
    
    /// 显示播放状态
    func showPlayStatus() {
        playButtonView.setTitle("播放", for: .normal)
    }
    
    /// 显示暂停状态
    func showPauseStatus() {
        playButtonView.setTitle("暂停", for: .normal)
    }
    
}

// MARK: -  播放管理器代理
extension SimplePlayerController:MusicPlayerManagerDelegate{
    func onPrepared(data: Song) {
        //显示初始化数据
//        showInitData()
//
//        //显示时长
//        showDuration()
//        
//        //选中当前音乐
//        scrollPosition()
    }
    
    func onPaused(data: Song) {
        showPlayStatus()
    }
    
    func onPlaying(data: Song) {
        showPauseStatus()
    }
    
    func onProgress(data: Song) {
//        showProgress()
    }
    
    func onLyricReady(data: Song) {
//        showLyricData()
    }
    
    func onError(data: Song) {
        
    }
}

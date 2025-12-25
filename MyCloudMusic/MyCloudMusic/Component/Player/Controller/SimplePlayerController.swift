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
    
    /// 是否按下了进度条
    var isTouchProgress = false
    
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

//        let data = Song()
//        data.title = "测试音乐"
//        MusicPlayerManager.shared()
//            .play(uri: "http://192.168.39.227:9178/assets/Wind.mp3", data: Song())
////            .play(uri: "http://10.0.0.47:9178/assets/Wind.mp3", data: Song())
            
    }
    
    override func initListeners() {
        super.initListeners()
        //监听应用进入前台了
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //监听应用进入后台了
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        //进度条拖拽监听
        progressView.addTarget(self, action: #selector(progressChanged(_:)), for: .valueChanged)
        progressView.addTarget(self, action: #selector(progressTouchDown(_:)), for: .touchDown)
        progressView.addTarget(self, action: #selector(progressTouchUp(_:)), for: .touchUpInside)
        progressView.addTarget(self, action: #selector(progressTouchUp(_:)), for: .touchUpOutside)
    }
    
    /// 进度条拖拽回调
    /// - Parameter sender: <#sender description#>
    @objc func progressChanged(_ sender:UISlider) {
        //将拖拽进度显示到界面
        //用户就很方便的知道自己拖拽到什么位置
        startView.text = SuperDateUtil.second2MinuteSecond(sender.value)
        
        //音乐切换到拖拽位置播放
        MusicPlayerManager.shared().seekTo(data: sender.value)
    }
    
    /// 进度条按下
    /// - Parameter sender: <#sender description#>
    @objc func progressTouchDown(_ sender:UISlider) {
        isTouchProgress=true
    }
    
    /// 进度条抬起
    /// - Parameter sender: <#sender description#>
    @objc func progressTouchUp(_ sender:UISlider) {
        isTouchProgress=false
    }
    
    func setMusicPlayerDelegate() {
        MusicPlayerManager.shared().delegate = self
        print("SimplePlayerController setMusicPlayerDelegate")
    }
    
    func removeMusicPlayerDelegate() {
        MusicPlayerManager.shared().delegate = nil
        print("SimplePlayerController removeMusicPlayerDelegate")
    }
    
    /// 进入前台了
    @objc func onEnterForeground() {
        initPlayData()
        
        setMusicPlayerDelegate()
    }
    
    /// 进入后台了
    @objc func onEnterBackground() {
        removeMusicPlayerDelegate()
    }
    
    /// 视图即将可见方法
    ///will：即将
    ///did：已经
    ///其他方法命名也都有这个规律
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("SimplePlayerController viewWillAppear")
    }
    
    /// 视图已经可见
    /// - Parameter animated: <#animated description#>
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("SimplePlayerController viewDidAppear")
        setMusicPlayerDelegate()
        
        initPlayData()
    }
    
    /// 视图即将消失
    /// - Parameter animated: <#animated description#>
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        print("SimplePlayerController viewWillDisappear")
    }
    
    /// 视图已经消失
    /// - Parameter animated: <#animated description#>
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        print("SimplePlayerController viewDidDisappear")
        removeMusicPlayerDelegate()
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
    
    /// 显示播放数据
    func initPlayData() {
        //显示初始化数据
        showInitData()
        
        //显示音乐时长
        showDuration()
        
        //显示播放进度
        showProgress()
        
        //显示播放状态
        showMusicPlayStatus()
        
//        //选中当前播放的音乐
//        scrollPosition()
//        
//        //显示歌词数据
//        showLyricData()
    }
    
    
    /// 显示初始化数据
    func showInitData() {
        //获取当前播放的音乐
        let data = MusicListManager.shared().data!

       //显示标题
        title = data.title
    }
    
    /// 显示音乐时长
    func showDuration() {
        let duration = MusicListManager.shared().data!.duration
        
        if (duration > 0) {
            endView.text = SuperDateUtil.second2MinuteSecond(duration)
            progressView.maximumValue = duration
        }
    }
    
    /// 显示播放进度
    func showProgress() {
        if isTouchProgress {
            return
        }
        
        let progress = MusicListManager.shared().data!.progress
        
        if (progress > 0) {
            startView.text = SuperDateUtil.second2MinuteSecond(progress)
            progressView.value = progress
        }
        
//        //显示歌词进度
//        lyricView.setProgress(progress)
    }
    
    func showMusicPlayStatus() {
        if MusicPlayerManager.shared().isPlaying() {
            showPauseStatus()
        } else {
            showPlayStatus()
        }
    }
    
    /// 播放或暂停
    func playOrPause() {
        if MusicPlayerManager.shared().isPlaying() {
            MusicListManager.shared().pause()
        } else {
            MusicListManager.shared().resume()
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
        showInitData()

        //显示时长
        showDuration()
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
        showProgress()
    }
    
    func onLyricReady(data: Song) {
//        showLyricData()
    }
    
    func onError(data: Song) {
        
    }
}

//音乐循环状态
enum MusicPlayRepeatModel:Int {
    case list=0 //列表循环
    case one //单曲循环
    case random //列表随机
}

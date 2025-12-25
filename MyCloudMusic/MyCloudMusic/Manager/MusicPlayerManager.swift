//
//  MusicPlayerManager.swift
//  播放管理器实现
//  封装了常用的音乐播放功能
//  例如：播放，暂停，继续播放等功能
//  目的就是对外面提供统一的接口
//  好处是内部自由的重构
//  只需要对外部接口不变
//
//  Created by Tao on 2025/12/24.
//

import Foundation

//导入媒体模块
import MediaPlayer

class MusicPlayerManager : NSObject{
    private static var instance:MusicPlayerManager?
    
    /// 当前播放的音乐
    private var data:Song?
    
    /// 播放器
    private var player:AVPlayer!
    
    /// 播放状态
    var status:PlayStatus = .none
    
    /// 代理对象，目的是将不同的状态分发出去
    weak open var delegate:MusicPlayerManagerDelegate?{
        didSet{
            if let _ = self.delegate {
                //有代理
                
                //判断是否有音乐在播放
                if self.isPlaying() {
                    //有音乐在播放
                    
                    //启动定时器
                    startPublishProgress()
                }
            }else {
                //没有代理
                
                //停止定时器
                stopPublishProgress()
            }
        }
    }
    
    ///播放完毕回调
    var complete:((_ data:Song)->Void)!
    
    /// 定时器返回的对象
    private var playTimeObserve:Any?
    
    /// 获取单例的播放管理器
    ///
    /// - Returns: <#return value description#>
    static func shared() -> MusicPlayerManager {
        if instance == nil {
            instance = MusicPlayerManager()
        }
        
        return instance!
    }
    
    private override init() {
        super.init()
        player = AVPlayer()
    }
    
    /// 播放
    /// - Parameters:
    ///   - uri: 绝对音乐地址
    ///   - data: 音乐对象
    func play(uri:String,data:Song) {
        //保存音乐对象
        self.data = data
        status = .playing
        var url:URL?=nil
        
        if uri.starts(with: "http") {
            //网络地址
            url = URL(string: uri)
        } else {
            //本地地址
            url = URL(fileURLWithPath: uri)
        }
        
        //创建一个播放Item
        let item = AVPlayerItem(url: url!)
        
        //替换掉原来的播放Item
        player.replaceCurrentItem(with: item)
        
        //播放
        player.play()
        
        //回调代理
        if let r = delegate {
            r.onPlaying(data: data)
        }
        
        //设置监听器
        //因为监听器是针对PlayerItem的
        //所以说播放了音乐在这里设置
        initListeners()
        
        //启动进度分发定时器
        startPublishProgress()
    }
    
    /// 暂停
    func pause() {
        //更改状态
        status = .pause
        
        //暂停
        player.pause()
        
        //回调代理
        if let r = delegate {
            r.onPaused(data: data!)
        }
        
        //移除监听器
        removeListeners()
        
        //停止进度分发定时器
        stopPublishProgress()
    }
    
    /// 继续播放
    func resume() {
        //请求获取音频会话焦点
//        SuperAudioSessionManager.requestAudioFocus()
        
        status = .playing
        
        player.play()
        
        //回调代理
        if let r = delegate {
            r.onPlaying(data: data!)
        }
        
        //设置监听器
        initListeners()
        
        //启动进度分发定时器
        startPublishProgress()
    }
    
    /// 开启进度回调通知
    private func startPublishProgress() {
        //判断是否启动了
        if let _  = playTimeObserve {
            //已经启动了
            return
        }
        
        //1/60秒，就是16毫秒
        playTimeObserve = player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(1.0), timescale: 60), queue: DispatchQueue.main, using: { time in
            
            //播放时间
            self.data!.progress = Float(CMTimeGetSeconds(time))
            
//            print("MusicPlayerManager progress \(self.data!.progress)")
            
            //判断是否有代理
            guard let delegate = self.delegate else {
                //没有回调
                //停止定时器
                self.stopPublishProgress()

                return
            }
            
            //回调代理
            delegate.onProgress(data: self.data!)
            
//            //保存播放进度，目的是进程杀死后，继续上次播放
//            //当然可以监听应用退出在保存
//
//            //获取当前时间0秒后的时间，就是当前
//            let date = Date(timeIntervalSinceNow: 0)
//
//            let currentTimeMillis=date.timeIntervalSince1970
//            let d=currentTimeMillis-self.lastSaveProgressTime
//            if d>MusicPlayerManager.SAVE_PROGRESS_TIME_INTERVAL {
//                //间隔大于指定值才保存，这样做是避免频繁操作
//                //具体的存储时间，存储间隔根据业务需求来更改
//                SuperDatabaseManager.shared.saveSong(self.data!)
//
//                self.lastSaveProgressTime = currentTimeMillis
//            }

        })
    }
    
    private func stopPublishProgress() {
        if let playTimeObserve = playTimeObserve {
            player.removeTimeObserver(playTimeObserve)
            self.playTimeObserve = nil
        }
    }
    
    /// 移动到指定位置播放
    func seekTo(data:Float) {
        let positionTime = CMTime(seconds: Double(data), preferredTimescale: 1)
        player.seek(to: positionTime)
    }
    
    /// 是否在播放
    /// - Returns: <#description#>
    func isPlaying() -> Bool {
        return status == .playing
    }
    
    private func initListeners() {
        //KVO方式监听播放状态
        //KVC:Key-Value Coding,另一种获取对象字段的值，类似字典
        //KVO:Key-Value Observing,建立在KVC基础上，能够观察一个字段值的改变
        player.currentItem?.addObserver(self, forKeyPath: MusicPlayerManager.STATUS, options: .new, context: nil)
        
        //监听音乐缓冲状态
        player.currentItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        
        //播放结束事件
        NotificationCenter.default.addObserver(self, selector: #selector(onComplete(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    /// 移除监听器
    private func removeListeners() {
        player.currentItem?.removeObserver(self, forKeyPath: MusicPlayerManager.STATUS)
        player.currentItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }
    
    /// 播放完毕了回调
    @objc func onComplete(_ sender:Notification) {
        complete(data!)
    }
    
    /// KVO监听回调方法
    ///
    /// - Parameters:
    ///   - keyPath: <#keyPath description#>
    ///   - object: <#object description#>
    ///   - change: <#change description#>
    ///   - context: <#context description#>
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //判断监听的字段
        if MusicPlayerManager.STATUS == keyPath {
            //播放状态
            switch player.status {
            case .readyToPlay:
                //准备播放完成了
                
                //音乐的总时间
                self.data!.duration = Float(CMTimeGetSeconds(player.currentItem!.asset.duration))
                
                //回调代理
                delegate?.onPrepared(data:data!)
                
//                updateMediaInfo()
            case .failed:
                //播放失败了
                status = .error
                
                delegate?.onError(data: data!)
            default:
                //未知状态
                status = .none
            }
        }
    }
    
    /// 更新系统媒体控制中心信息
    /// 不需要更新进度到控制中心
    /// 他那边会自动倒计时
    /// 这部分可以重构到公共类，因为像播放视频也可以更新到系统媒体中心
    private func updateMediaInfo() {
        //下载图片
        //这部分可以封装
        //因为其他界面可能也会用
        let manager = SDWebImageManager.shared

        if data?.icon == nil {
            self.setMediaInfo(R.image.placeholder()!)
        } else {
            let url = URL(string: data!.icon!.absoluteUri())

            //下载图片
            manager.loadImage(with: url, options: .progressiveLoad) { receivedSize, expectedSize, targetURL in

            } completed: { image, data, error, cacheType, finished, imageURL in
                print("load song image success \(url)")
                if let r = image {
                    self.setMediaInfo(r)
                }
            }
        }
    }
    
    private func setMediaInfo(_ image:UIImage)  {
        //初始化一个可变字典
        var songInfo:[String:Any] = [:]

        //封面
        let albumArt = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100)) { size -> UIImage in
            return image
        }

        //封面
        songInfo[MPMediaItemPropertyArtwork]=albumArt

        //歌曲名称
        songInfo[MPMediaItemPropertyTitle]=data!.title

        //歌手
        songInfo[MPMediaItemPropertyArtist]=data!.singer.nickname

        //专辑名称
        //由于服务端没有返回专辑的数据
        //所以这里就写死数据就行了
        songInfo[MPMediaItemPropertyAlbumTitle]="这是专辑名称"

        //流派
        //songInfo[MPMediaItemPropertyGenre]="这是流派"

        //总时长
        songInfo[MPMediaItemPropertyPlaybackDuration]=data!.duration

        //已经播放的时长
        songInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime]=data!.progress

        //歌词
        songInfo[MPMediaItemPropertyLyrics]="这是歌词"

        //设置到系统
        MPNowPlayingInfoCenter.default().nowPlayingInfo = songInfo
    }
    
    
    static let STATUS = "status"
}

/// 播放状态枚举
enum PlayStatus {
    case none //未知
    case pause //暂停了
    case playing //播放中
    case prepared //准备中
    case completion //当前这一首音乐播放完成
    case error
}

/// 播放管理器代理
protocol MusicPlayerManagerDelegate:NSObjectProtocol{
    /// 播放器准备完毕了
    /// 可以获取到音乐总时长
    func onPrepared(data:Song)
    
    /// 暂停了
    func onPaused(data:Song)
    
    /// 正在播放
    func onPlaying(data:Song)
    
    /// 进度回调
    func onProgress(data:Song)
    
    /// 歌词数据准备好了
    func onLyricReady(data:Song)
    
    /// 出错了
    func onError(data:Song)
}

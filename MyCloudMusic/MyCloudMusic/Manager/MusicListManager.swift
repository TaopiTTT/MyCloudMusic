//
//  MusicListManager.swift
//  列表管理器
//  主要是封装了列表相关的操作
//  例如：上一曲，下一曲，循环模式
//
//  Created by Tao on 2025/12/24.
//

import Foundation
import SwiftEventBus

class MusicListManager {
    private static var instance:MusicListManager?
    
    /// 当前音乐对象
    var data:Song?
    
    //播放列表
    var datum:[Song] = []
    
    /// 播放管理器
    var musicPlayerManager:MusicPlayerManager!
    
    /// 是否播放了
    var isPlay = false
    
    /// 循环模式,默认列表循环
    var model:MusicPlayRepeatModel = .list
    
    /// 获取单例的播放列表管理器
    ///
    /// - Returns: <#return value description#>
    static func shared() -> MusicListManager {
        if instance == nil {
            instance = MusicListManager()
        }
        
        return instance!
    }
    
    private init() {
        //初始化音乐播放管理器
        musicPlayerManager = MusicPlayerManager.shared()
        
        //设置播放完毕回调
        musicPlayerManager.complete = {d in
            //判断播放循环模式
            if self.model == .one {
                //单曲循环
                self.play(d)
            }else{
                //其他模式
                self.play(self.next())
            }
        }
        
//        initPlayList()
    }
    
    /// 设置音乐列表
    /// - Parameter datum: <#datum description#>
    func setDatum(_ datum:[Song]) {
//        //将原来数据list标志设置为false
//       DataUtil.changePlayListFlag(self.datum, false)
//
//       //保存到数据库
//       saveAll()
        
        //清空原来的数据
        self.datum.removeAll()
        
        //添加新的数据
        self.datum += datum
        
//        //更改播放列表标志
//        DataUtil.changePlayListFlag(self.datum, true)
//
//        //保存到数据库
//        saveAll()
//
//        sendMusicListChanged()
    }
    
    /// 播放
    /// - Parameter data: <#data description#>
    func play(_ data:Song) {
        self.data = data
        
        let path = data.uri.absoluteUri()
        
//        //标记为播放了
//        isPlay = true
//        
//        var path:String!
//        
//        //查询是否有下载任务
//        let downloadInfo = AppDelegate.shared.getDownloadManager().findDownloadInfo(data.id)
//        if downloadInfo != nil && downloadInfo.status == .completed {
//            //下载完成了
//
//           //播放本地音乐
//            path = StorageUtil.documentUrl().appendingPathComponent(downloadInfo.path).path
//            print("MusicListManager play offline \(path!) \(data.uri!)")
//        } else {
//            //播放在线音乐
//            path = data.uri.absoluteUri()
//            print("MusicListManager play online \(path!) \(data.uri!)")
//        }
//        
        musicPlayerManager.play(uri: path, data: data)
//        
//        //设置最后播放音乐的Id
//        PreferenceUtil.setLastPlaySongId(data.id)

    }
    
    /// 暂停
    func pause() {
        musicPlayerManager.pause()
    }
    
    /// 继续播放
    func resume() {
        if isPlay {
            //原来已经播放过
            //也就说播放器已经初始化了
            musicPlayerManager.resume()
        } else {
            //到这里，是应用开启后，第一次点继续播放
            //而这时内部其实还没有准备播放，所以应该调用播放
            play(data!)
            
            //判断是否需要继续播放
            if data!.progress>0 {
                //有播放进度

                //就从上一次位置开始播放
                musicPlayerManager.seekTo(data: data!.progress)
            }
        }
    }
    
    @discardableResult
    /// 更改循环模式
    func changeLoopModel() -> MusicPlayRepeatModel {
        //将当前循环模式转为int
        var model = self.model.rawValue
        
        //循环模式+1
        model += 1
        
        //判断边界
        if model > MusicPlayRepeatModel.random.rawValue {
            //超出了范围
            model = 0
        }
        
        self.model = MusicPlayRepeatModel(rawValue: model)!
        
        return self.model
    }
    
    /// 获取上一个
    func previous() -> Song {
        var index = 0
        switch model {
        case .random:
            //随机循环
            
            //在0~datum.size-1范围中
            //产生一个随机数
            index = Int(arc4random()) % datum.count
        default:
            //列表循环
            let datumOC = datum as NSArray
            index = datumOC.index(of: data!)
            
            //如果当前播放的音乐是最后一首音乐
            if index == 0 {
                //当前播放的是第一首音乐
                index = datum.count - 1
            } else {
                index -= 1
            }
        }
        
        return datum[index]
    }
    
    /// 获取下一个
    func next() -> Song {
        var index = 0
        switch model {
        case .random:
            //随机循环
            
            //在0~datum.size-1范围中
            //产生一个随机数
            index = Int(arc4random()) % datum.count
        default:
            //列表循环
            let datumOC = datum as NSArray
            index = datumOC.index(of: data!)
            
            //如果当前播放的音乐是最后一首音乐
            if index == datum.count - 1 {
                //当前播放的是最后一首音乐
                index = 0
            } else {
                index += 1
            }
        }
        
        return datum[index]
    }
    
    /// 从该位置播放
    /// - Parameter data: <#data description#>
    func seekTo(_ data:Float)  {
        musicPlayerManager.seekTo(data: data)
        
        //如果暂停了就继续播放
        if !musicPlayerManager.isPlaying() {
            resume()
        }
    }
    
}

//音乐循环状态
enum MusicPlayRepeatModel:Int {
    case list=0 //列表循环
    case one //单曲循环
    case random //列表随机
}

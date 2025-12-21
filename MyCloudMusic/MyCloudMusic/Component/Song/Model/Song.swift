//
//  Song.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/21.
//

import UIKit

import HandyJSON

class Song: BaseCommon {
    /// 标题
    var title:String!
    
    /// 封面
    var icon:String?
    
    /// 音乐地址
    var uri:String!
    
    /// 点击数
    var clicksCount:Int = 0
    
    /// 评论数
    var commentsCount:Int = 0
    
    /// 创建该音乐的人
    var user:User!
    
    /// 歌手
    var singer:User!
    
    /// 歌词类型
    var style:Int = 0
    
    /**
     * 歌词内容
     */
    var lyric:String? = nil
    
    
    // MARK: -  播放后才有值
    /// 总进度
    /// 单位：秒
    var duration:Float = 0

    /// 播放进度
    var progress:Float = 0
    
    /**
     * 歌手Id
     * <p>
     * 在sqlite，mysql这样的数据库中
     * 字段名建议用下划线
     * 而不是驼峰命名
     *
     * 用来将歌手对象拆分到多个字段，方便在一张表存储，和查询
     */
    var singerId:String!

    /**
     * 歌手名称
     */
    var singerNickname:String!

    /**
     * 歌手头像
     * 可选值
     */
    var singerIcon:String?
    
    /// 是否在播放列表
    var list:Bool=false

    /// 音乐来源
    var source:Int=0
    
    /**
     * 本地扫描的音乐路径
     * 也是相对位置
     *
     * 在线的音乐下载后路径在下载对象那边
     */
    var path:String? = nil
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.clicksCount <-- "clicks_count"
        mapper <<< self.commentsCount <-- "comments_count"
    }
}

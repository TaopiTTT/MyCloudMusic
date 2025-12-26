//
//  Song.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/21.
//

import UIKit

import HandyJSON

//腾讯开源的数据库框架
import WCDBSwift

class Song: BaseCommon,TableCodable {
    static let NAME = "Song"
    
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
    
//    /**
//     * 歌词内容
//     */
    var lyric:String? = nil
    
    /// 解析后的歌词
    var parsedLyric:Lyric?
    
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
    
    // MARK: - 初始化器（必须在类定义内部）
        required override init() {
            super.init()
        }
        

        private enum JsonKeys: String, CodingKey {
            case id, title, icon, uri
            case clicksCount, commentsCount
            case style, duration, progress
            case list, source, path, lyric
            case singerId, singerNickname, singerIcon
            case createdAt, updatedAt
        }
        
        required init(from decoder: Decoder) throws {
            super.init()
            let container = try decoder.container(keyedBy: JsonKeys.self)
            
            id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
            title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
            icon = try container.decodeIfPresent(String.self, forKey: .icon) ?? ""
            uri = try container.decodeIfPresent(String.self, forKey: .uri) ?? ""
            clicksCount = try container.decodeIfPresent(Int.self, forKey: .clicksCount) ?? 0
            commentsCount = try container.decodeIfPresent(Int.self, forKey: .commentsCount) ?? 0
            style = try container.decodeIfPresent(Int.self, forKey: .style) ?? 0
            duration = try container.decodeIfPresent(Float.self, forKey: .duration) ?? 0
            progress = try container.decodeIfPresent(Float.self, forKey: .progress) ?? 0
            list = try container.decodeIfPresent(Bool.self, forKey: .list) ?? false
            source = try container.decodeIfPresent(Int.self, forKey: .source) ?? 0
            path = try container.decodeIfPresent(String.self, forKey: .path)
            lyric = try container.decodeIfPresent(String.self, forKey: .lyric)
            singerId = try container.decodeIfPresent(String.self, forKey: .singerId) ?? ""
            singerNickname = try container.decodeIfPresent(String.self, forKey: .singerNickname) ?? ""
            singerIcon = try container.decodeIfPresent(String.self, forKey: .singerIcon) ?? ""
            createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
            updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: JsonKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(icon, forKey: .icon)
            try container.encode(uri, forKey: .uri)
            try container.encode(clicksCount, forKey: .clicksCount)
            try container.encode(commentsCount, forKey: .commentsCount)
            try container.encode(style, forKey: .style)
            try container.encode(duration, forKey: .duration)
            try container.encode(progress, forKey: .progress)
            try container.encode(list, forKey: .list)
            try container.encode(source, forKey: .source)
            try container.encodeIfPresent(path, forKey: .path)
            try container.encodeIfPresent(lyric, forKey: .lyric)
            try container.encode(singerId, forKey: .singerId)
            try container.encode(singerNickname, forKey: .singerNickname)
            try container.encode(singerIcon, forKey: .singerIcon)
            try container.encodeIfPresent(createdAt, forKey: .createdAt)
            try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        }
        
        // MARK: - Singer 转换
        func convertLocal() {
            singerId = singer.id
            singerNickname = singer.nickname
            singerIcon = singer.icon
        }
        
        func localConvert() {
            singer = User()
            singer.id = singerId
            singer.nickname = singerNickname
            singer.icon = singerIcon
        }
        
        // MARK: - WCDB 模型绑定
        enum CodingKeys: String, CodingTableKey {
            typealias Root = Song
            static let objectRelationalMapping = TableBinding(CodingKeys.self)
            
            case id
            case title
            case icon
            case uri
            case clicksCount
            case commentsCount
            case style
            case duration
            case progress
            case list
            case source
            case path
            case lyric
            case singerId
            case singerNickname
            case singerIcon
            case createdAt
            case updatedAt
            
            static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
                return [
                    .id: ColumnConstraintBinding(isPrimary: true),
                    .title: ColumnConstraintBinding(isNotNull: true)
                ]
            }
        }

}

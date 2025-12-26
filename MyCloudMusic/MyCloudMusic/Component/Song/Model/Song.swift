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
    
    /**
     * 歌词内容
     */
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
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: Song.CodingKeys.id)
        title = try container.decode(String.self, forKey: .title)
        icon = try container.decode(String.self, forKey: .icon)
        uri = try container.decode(String.self, forKey: .uri)
        clicksCount = try container.decode(Int.self, forKey: .clicksCount)
        commentsCount = try container.decode(Int.self, forKey: .commentsCount)
        style = try container.decode(Int.self, forKey: .style)
        duration = try container.decode(Float.self, forKey: .duration)
        progress = try container.decode(Float.self, forKey: .progress)
        list = try container.decode(Bool.self, forKey: .list)
        source = try container.decode(Int.self, forKey: .source)
        path = try container.decode(String.self, forKey: .path)
        lyric = try container.decode(String.self, forKey: .lyric)
        singerId = try container.decode(String.self, forKey: .singerId)
        singerNickname = try container.decode(String.self, forKey: .singerNickname)
        singerIcon = try container.decode(String.self, forKey: .singerIcon)
        createdAt = try? container.decode(String.self, forKey: .createdAt)
        updatedAt = try? container.decode(String.self, forKey: .updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(title, forKey: .title)
        try? container.encodeIfPresent(icon, forKey: .icon)
        try? container.encode(uri, forKey: .uri)
        try? container.encode(clicksCount, forKey: .clicksCount)
        try? container.encode(commentsCount, forKey: .commentsCount)
        try? container.encode(style, forKey: .style)
        try? container.encode(duration, forKey: .duration)
        try? container.encode(progress, forKey: .progress)
        try? container.encode(list, forKey: .list)
        try? container.encode(source, forKey: .source)
        try? container.encodeIfPresent(path, forKey: .path)
        try? container.encodeIfPresent(lyric, forKey: .lyric)
        try? container.encode(singerId, forKey: .singerId)
        try? container.encode(singerNickname, forKey: .singerNickname)
        try? container.encode(singerIcon, forKey: .singerIcon)
        try? container.encode(createdAt, forKey: .createdAt)
        try? container.encode(updatedAt, forKey: .updatedAt)
    }

    required init() {

    }
    
    func convertLocal() {
        singerId = singer.id
        singerNickname = singer.nickname
        singerIcon = singer.icon
    }

    func localConvert() {
        singer = User()
        singer.id=singerId
        singer.nickname=singerNickname
        singer.icon=singerIcon
    }
    
    //WCDB模型绑定
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
                id: ColumnConstraintBinding(isPrimary: true), //主键
                title: ColumnConstraintBinding(isNotNull: true) //索引
            ]
        }
    }

}

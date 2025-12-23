//
//  Sheet.swift
//  歌单对象
//
//  Created by Tao on 2025/12/17.
//

import Foundation

//导入JSON解析框架
import HandyJSON

class Sheet:BaseCommon {
    /// 歌单标题
    var title:String!

    /// 歌单封面
    var icon:String?

    /// 点击数
    var clicksCount:Int=0

    /// 收藏数
    var collectsCount:Int=0

    /// 评论数
    var commentsCount:Int=0

    /// 音乐数量
    var songsCount:Int=0

    /// 歌单创建者
    var user:User!

    /// 歌曲列表
    var songs:Array<Song>?
    
    var detail:String?
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.clicksCount <-- "clicks_count"
        mapper <<< self.collectsCount <-- "collects_count"
        mapper <<< self.commentsCount <-- "comments_ount"
        mapper <<< self.songsCount <-- "songs_count"
    }
}

//
//  Session.swift
//  用户登录后返回数据模型
//
//  Created by Tao on 2025/12/23.
//

import UIKit

//导入JSON解析框架
import HandyJSON

class Session: BaseModel {
    /// 用户Id
    var userId:String!
    
    /// 登录后的Session
    var session:String!
    
    /// 聊天token
    var chatToken:String!

    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.userId <-- "user_id"
        mapper <<< self.chatToken <-- "chat_token"
    }
}

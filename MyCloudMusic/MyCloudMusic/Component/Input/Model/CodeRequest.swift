//
//  CodeRequest.swift
//  请求验证码参数模型
//
//  Created by Tao on 2025/12/23.
//

import Foundation

class CodeRequest: BaseModel {
    var phone:String!
    var email:String!
    
    /// 如果发送频繁了，也可以邀请发送验证码时，传递图形验证码
    var code:String!
}

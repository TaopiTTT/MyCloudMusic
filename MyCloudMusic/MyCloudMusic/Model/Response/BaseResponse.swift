//
//  BaseResponse.swift
//  通用网络请求响应模型
//
//  Created by Tao on 2025/12/17.
//

import Foundation

class BaseResponse: BaseModel {
    /// 状态码
    var status:Int = 0
    
    /// 错误信息
    /// 发生了错误不一定有
    var message:String?
}

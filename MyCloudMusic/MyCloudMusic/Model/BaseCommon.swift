//
//  BaseCommon.swift
//  通用字段模型
//
//  Created by Tao on 2025/12/17.
//

import UIKit

//导入JSON解析框架
import HandyJSON
 
class BaseCommon: BaseId {
    /// 创建时间
    var createdAt:String!
    
    /// 更新时间
    var updatedAt:String!
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.createdAt <-- "created_at"
        mapper <<< self.updatedAt <-- "updated_at"
    }
}

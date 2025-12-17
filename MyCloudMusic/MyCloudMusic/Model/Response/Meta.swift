//
//  Meta.swift
//  分页模型
//
//  Created by Tao on 2025/12/17.
//

import Foundation
import HandyJSON

class Meta<T:HandyJSON>: BaseModel {
    /// 真实数据
    var data:[T]?
    
    /// 有多少条
    var total:Int!

    /// 有多少页
    var pages:Int!

    /// 当前每页显示多少条
    var size:Int!

    /// 当前页
    var page:Int!

    /// 下一页
    var next:Int?
    
    /// 获取下一页
    static func nextPage(_ data:Meta?) -> Int {
        if let meta = data,let next = meta.next {
            return next
        }
        
        return 1
    }
}

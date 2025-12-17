//
//  DetailResponse.swift
//  详情网络请求解析类
//
//  Created by Tao on 2025/12/17.
//

import Foundation
import HandyJSON

/// 继承BaseResponse
/// 定义了一个泛型T
/// 泛型实现了HandyJSON协议
/// 因为我们希望用户传递的类要能解析为JSON
class DetailResponse<T:HandyJSON>: BaseResponse {
    /// 真实数据
    /// 他的类型就是泛型
    var data:T?
    
    init(_ data:T) {
        self.data = data
    }
    
    required init() {
        super.init()
    }
}

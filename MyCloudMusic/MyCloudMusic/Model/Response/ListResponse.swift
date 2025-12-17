//
//  ListResponse.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/17.
//

import Foundation
import HandyJSON

class ListResponse<T:HandyJSON>: BaseResponse {
    /// 分页元数据
    var data:Meta<T>!
}

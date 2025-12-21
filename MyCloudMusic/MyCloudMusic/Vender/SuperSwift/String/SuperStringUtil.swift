//
//  SuperStringUtil.swift
//   字符串工具类
//
//  Created by Tao on 2025/12/21.
//

import Foundation

import SwifterSwift

class SuperStringUtil {
    /// 是否不为空
    /// - Parameter data: <#data description#>
    /// - Returns: <#description#>
    static func isNotBlank(_ data:String?) -> Bool {
        return !isBlank(data)
    }
    
    /// 是否为空
    /// - Parameter data: <#data description#>
    /// - Returns: <#description#>
    static func isBlank(_ data:String?) -> Bool {
        var data=data
        data=data?.trimmed
        
        return data == nil || data!.isEmpty
    }
}

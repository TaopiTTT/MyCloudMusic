//
//  ResourceUtil.swift
//  资源工具类
//
//  Created by Tao on 2025/12/19.
//

import Foundation

class ResourceUtil {
    /// 将相对路径的资源转为绝对路径
    ///
    /// - Parameter uri: <#uri description#>
    /// - Returns: <#return value description#>
    static func resourceUri(_ data:String) -> String {
        return "\(Config.RESOURCE_ENDPOINT)/\(data)"
    }
}

//
//  DataUtil.swift
//  数据处理工具类
//
//  Created by Tao on 2025/12/26.
//

import Foundation

class DataUtil {
    /// 更改是否在播放列表字段
    /// - Parameters:
    ///   - data: <#data description#>
    ///   - inList: <#inList description#>
    static func changePlayListFlag(_ data:[Song], _ inList:Bool) {
        for it in data {
            it.list = inList
        }
    }
    
//    /// 处理消息
//    /// - Parameter data: <#data description#>
//    /// - Returns: <#description#>
//    static func processMessage(_ data:[RCMessage]) -> [RCMessage] {
//        //按照时间从小到大
//
//        //由于是不可变数组，所以排序后返回新的数据
//        return data.sorted { (obj1, obj2) -> Bool in
//            return obj1.sentTime < obj2.sentTime
//        }
//    }
}

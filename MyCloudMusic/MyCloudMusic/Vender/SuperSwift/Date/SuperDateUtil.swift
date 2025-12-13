//
//  SuperDateUtil.swift
//  日期工具类
//
//  Created by Tao on 2025/12/13.
//

import Foundation

class SuperDateUtil {
    
    /// 当前年份
    /// - Returns:  year(Int)
    static func currentYear() -> Int {
        // 当前日期
        let date = Date()
        let calender = Calendar.current
        
        // 获取到的日期有哪些元素
        let d = calender.dateComponents([Calendar.Component.year,Calendar.Component.month], from: date)
        
        return d.year!
    }
}

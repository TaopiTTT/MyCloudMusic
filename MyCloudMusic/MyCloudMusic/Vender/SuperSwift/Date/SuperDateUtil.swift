//
//  SuperDateUtil.swift
//  日期工具类
//
//  Created by Tao on 2025/12/13.
//

import Foundation

class SuperDateUtil {
    
    /// 当前年
    /// - Returns: <#description#>
    static func currentYear() -> Int {
        //当前日期
        let date = Date()
        
        let calender = Calendar.current
        
        //这句是说你要获取日期的元素有哪些
        let d = calender.dateComponents([Calendar.Component.year,Calendar.Component.month], from: date)
        
        //然后就可以从d中获取具体的年月日了
        return d.year!
    }

    /// 当前天
    /// - Returns: <#description#>
    static func currentDay() -> Int {
        let date = Date()
        let calender = Calendar.current
        let d = calender.dateComponents([Calendar.Component.day], from: date)
        
        return d.day!
    }
    
    /// 将float秒（3.867312）格式化为：150:11
    /// - Parameter data: <#data description#>
    /// - Returns: description
    static func second2MinuteSecond(_ data:Float) -> String {
        let minute = Int(data/60)
        let second = Int(data) % 60
        return String(format: "%02d:%02d",minute,second)
    }
    
    /// 把iso8601字符串格式化为通用格式
    /// - Parameter data: <#data description#>
    /// - Returns: 例如：1秒前，2天前
    static func commonFormat(_ data:String) -> String {
        //先将字符串转为Date
        let date = dateFromISO8601String(data)
        
        return commonFormat(date)
    }
    
    /// 把date格式化为通用格式
    /// - Parameter data: <#data description#>
    /// - Returns: 例如：1秒前，2天前
    static func commonFormat(_ data:Date) -> String {
        //当前时间
        let now = Date.init()
        
        //创建日历对象
        //计算日期事件之间的差就更方便
        let calendar = Calendar.current
        
        //获取哪些值
        let unitFlags:Set<Calendar.Component>=[Calendar.Component.year,.month,.weekOfMonth,.day,.hour,.minute,.second]
        
        //计算两个日期之间的差
        let cmps = calendar.dateComponents(unitFlags, from: data, to: now)
        
        var result = ""
        if cmps.second!<=0 {
            result = "现在"
        }else if (cmps.second! > 0 && cmps.minute! <= 0){
            result = "\(cmps.second!)秒前"
        }else if (cmps.minute! > 0 && cmps.hour! <= 0) {
            result = "\(cmps.minute!)分钟前"
        }else if (cmps.hour! > 0 && cmps.day! <= 0) {
            result = "\(cmps.hour!)小时前"
        }else if (cmps.day! > 0 && cmps.weekOfMonth! <= 0) {
            result = "\(cmps.day!)天前"
        }else if (cmps.weekOfMonth! > 0 && cmps.month! <= 0) {
            result = "\(cmps.weekOfMonth!)周前"
        }else if (cmps.month! > 0 && cmps.year! <= 0) {
            result = "\(cmps.month!+1)月前"
        }else{
            result = format(YYMMDDHHMM, data)
        }
        
        return result
    }
    
    static func format(_ format:String,_ data:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: data)
    }
    
    /// 将iso8601格式字符串转为date
    /// - Parameter data: <#data description#>
    /// - Returns: <#description#>
    static func dateFromISO8601String(_ data:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = ISO8601_DATE_TIME_FORMAT
        let r=formatter.date(from: data)!
        
        return r
    }
    
    /// 转为yyyy-MM-dd HH:mm
    /// - Parameter data: <#data description#>
    /// - Returns: <#description#>
    static func yearMonthDayHourMinute(_ data:String) -> String {
        //先将字符串转为NSDate
        let date = dateFromISO8601String(data)
        
        return format(YYMMDDHHMM,date)
    }
    
    /// 转为HH:mm:ss
    static func hhmmss(_ data:Date) -> String {
        return format(HHMMSS, data)
    }
    
    static let ISO8601_DATE_TIME_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSzzz"
    static let YYMMDDHHMM = "yyyy-MM-dd HH:mm"
    static let HHMMSS = "HH:mm:ss"
}


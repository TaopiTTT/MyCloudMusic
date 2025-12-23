//
//  CountDownUtil.swift
//  倒计时相关工具类
//
//  Created by Tao on 2025/12/23.
//

import Foundation

class CountDownUtil {
    static var timer:DispatchSource?
    
    //倒计时验证码
    static func countDown(_ data: Int, callback:@escaping ((Int)->Void)){
       //倒计时时间
        var timeout=data
       let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
       timer = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
        timer!.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
       //每秒执行
       timer!.setEventHandler(handler: { () -> Void in
           timeout -= 1
           DispatchQueue.main.sync {
               callback(timeout)
           }
           
           if timeout == 0 {
               timer = nil
           }
       })
       timer!.resume()
    }
    
    /// 取消
    static func cancel() {
        timer?.cancel()
        timer = nil
    }
}

//
//  ObservableMoyaExtension.swift
//  对Observable扩展moya网络相关功能
//
//  Created by Tao on 2025/12/17.
//

import Foundation

//导入JSON解析框架
import HandyJSON

//导入网络框架
import Moya

//响应式编程框架
import RxSwift

/// 自定义错误
///
/// - objectMapping: 表示JSON解析为对象失败
public enum IxueaError: Swift.Error {
    case objectMapping
}

extension Observable {
    /// 将字符串解析为对象
    ///
    /// - Parameter type: 要转为的类
    /// - Returns: 转换后的观察者对象
    public func mapObject<T:HandyJSON>(_ type:T.Type) -> Observable<T> {
        map { data in
            //将参数尝试转为字符串
            guard let dataString = data as? String else {
                //data不能转为字符串
                throw IxueaError.objectMapping
            }
            
            guard let result = type.deserialize(from: dataString) else{
                throw IxueaError.objectMapping
            }
            
            //解析成功
            //返回解析后的对象
            return result
        }
        
    }
}

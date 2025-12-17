//
//  ParamUtil.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/17.
//

import Foundation
import Moya

class ParamUtil {
    /// 返回URL编码的参数
    ///
    /// - Parameter parameters: <#parameters description#>
    static func urlRequestParamters(_ data:[String:Any]) -> Task {
        return .requestParameters(parameters: data, encoding: URLEncoding.default)
    }
    
}

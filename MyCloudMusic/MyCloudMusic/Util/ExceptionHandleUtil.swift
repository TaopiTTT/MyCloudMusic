//
//  ExceptionHandleUtil.swift
//  错误处理工具类
//
//  Created by Tao on 2025/12/18.
//

import Foundation
//导入网络框架
import Moya
import Alamofire

class ExceptionHandleUtil {
    /// 处理网络响应
    /// - Parameters:
    ///   - data: <#data description#>
    ///   - error: <#error description#>
    static func handlerResponse(_ data:BaseResponse?=nil,_ error:Error?=nil) {
        if error != nil {
            //先处理有异常的请求
            handlerError(error!)
        } else {
            if let r = data?.message{
                //有错误提示
                SuperToast.show(title: r)
            } else {
                SuperToast.show(title: R.string.localizable.errorUnknown())
            }
        }
    }
    
    /// 处理错误
    /// - Parameter error: <#error description#>
    static func handlerError(_ error:Error) {
        if let error = error as? MoyaError {
            switch error {
            case .stringMapping(_):
                SuperToast.show(title: "响应转换为字符串错误")
            case .statusCode(let response):
                //响应码
                let code = response.statusCode
                handleHttpError(code)
            case .underlying(let _ as NSError, _):
                if let alamofireError = error.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError,
                   let underlyingError = alamofireError.underlyingError as? NSError{
                    switch underlyingError.code {
                    case NSURLErrorNotConnectedToInternet:
                        //没有网络连接，例如：关闭了网络
                        SuperToast.show(title: R.string.localizable.networkError())
                    case NSURLErrorTimedOut:
                        //连接超时，例如：网络特别慢
                        SuperToast.show(title: R.string.localizable.errorNetworkTimeout())
                    case NSURLErrorCannotFindHost:
                        //域名无法解析，例如：域名写错了
                        SuperToast.show(title: R.string.localizable.errorNetworkUnknownHost())
                    case NSURLErrorCannotConnectToHost:
                        //无法连接到主机，例如：解析的ip地址，或者直接写的ip地址无法连接
                        SuperToast.show(title: R.string.localizable.errorNetworkUnknownHost())
                    default:
                        SuperToast.show(title: R.string.localizable.errorUnknown())
                    }
                }else{
                    SuperToast.show(title: R.string.localizable.errorUnknown())
                }
            default:
                SuperToast.show(title: R.string.localizable.errorUnknown())
            }
        }
    }
    
    static func handleHttpError(_ data:Int) {
        switch data {
        case 401:
            SuperToast.show(title: R.string.localizable.errorNetworkNotAuth())
            AppDelegate.shared.logout()
        case 403:
            SuperToast.show(title: R.string.localizable.errorNetworkNotPermission())
        case 404:
            SuperToast.show(title: R.string.localizable.errorNetworkNotFound())
        case 500..<599:
            SuperToast.show(title: R.string.localizable.errorNetworkServer())
        default:
            SuperToast.show(title: R.string.localizable.errorUnknown())
        }
    }
    
    
}

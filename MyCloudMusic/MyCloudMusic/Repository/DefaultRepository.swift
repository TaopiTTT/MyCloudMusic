//
//  DefaultRepository.swift
//  网络请求仓库
//
//  Created by Tao on 2025/12/18.
//

import Foundation

//导入响应式编程框架
import RxSwift

//导入JSON解析框架
import HandyJSON

//导入网络框架
import Moya

class DefaultRepository {
    static let shared = DefaultRepository()
    
    private var provider:MoyaProvider<DefaultService>!
    
    /// 歌单列表
    /// - Parameter size: <#size description#>
    /// - Returns: <#description#>
    func sheets(size:Int) -> Observable<ListResponse<Sheet>> {
        return provider
                .rx
                .request(.sheets(size: size))
                .asObservable()
                .mapString()
                .mapObject(ListResponse<Sheet>.self)
    }
    
    /// 歌单详情
    /// - Parameter data: <#data description#>
    /// - Returns: <#description#>
    func sheetDetail(_ data:String) -> Observable<DetailResponse<Sheet>> {
        return provider
                .rx
                .request(.sheetDetail(data: data))
                .asObservable()
                .mapString()
                .mapObject(DetailResponse<Sheet>.self)
    }
    
    /// 私有构造方法
    private init() {
        //插件列表
        var plugins:[PluginType] = []
        
        if Config.DEBUG {
            //表示当前是调试模式
            //添加网络请求日志插件
            plugins.append(NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose)))
        }
        
        //网络请求加载对话框
        let networkActivityPlugin = NetworkActivityPlugin { change, target in
            //changeType类型是NetworkActivityChangeType
            //通过它能监听到开始请求和结束请求

            //targetType类型是TargetType
            //就是我们这里的service
            //通过它能判断是那个请求
            if change == .began {
                //开始请求
                let targetType = target as! DefaultService
    
                switch targetType {
                case .sheetDetail,.register:
                    DispatchQueue.main.async {
                        //切换到主线程
                        SuperToast.showLoading()
                    }
                default:
                    break
                }
            } else {
                //结束请求
                DispatchQueue.main.async {
                    SuperToast.hideLoading()
                }
            }
        }
        
        plugins.append(networkActivityPlugin)
        
        provider = MoyaProvider<DefaultService>(plugins: plugins)
    }
}

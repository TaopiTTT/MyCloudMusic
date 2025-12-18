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

//http网络请求观察者
public class HttpObserver<Element>:ObserverType{
    /// ObserverType协议中用到了泛型E
    /// 所以说子类中就要指定E这个泛型
    /// 不然就会报错
    public typealias E = Element
    
    public typealias successCallback = ((E)-> Void)
    
    /// 请求成功回调
    var success:successCallback
    
    /// 请求失败回调
    var error:((BaseResponse?,Error?)-> Bool)?
    
    var controller:BaseLogicController?
    
    /// 构造方法
    ///
    /// - Parameters:
    ///   - onSuccess: 请求成功的回调
    ///   - onError: 请求失败的回调
    init(_ success:@escaping successCallback,_ error: ((BaseResponse?,Error?)-> Bool)?, _ controller:BaseLogicController?=nil) {
        self.success = success
        self.error = error
        self.controller = controller
        
//        controller?.placeholderView.hide()
    }
    
    /// 当RxSwift框架里面发送了事件回调
    ///
    /// - Parameter event: <#event description#>
    public func on(_ event: Event<Element>) {
        switch event {
        case .next(let data):
//            print("HttpObserver next \(data)")
            
            //将值尝试转为BaseResponse
            let baseResponse = data as? BaseResponse
            
            if baseResponse?.status != 0 {
                //状态码不等于0
                //表示请求出错了
                handlerResponse(baseResponse:baseResponse)
            } else {
                //请求正常
                success(data)
            }
        case .error(let error):
            //请求失败
            print("HttpObserver error:\(error)")
            
//            handlerResponse(error:error)
            
        case .completed:
            //请求完成
            print("HttpObserver completed")
            break
        }
    }
    
    /// 尝试处理错误网络请求
    ///
    /// - Parameters:
    ///   - baseResponse: 请求返回的对象
    ///   - error: 错误信息
    func handlerResponse(baseResponse:BaseResponse?=nil,error:Error?=nil) {
        if self.error != nil && self.error!(baseResponse,error) {
            //回调失败block
            //返回true，父类不自动处理错误
            
            //子类需要关闭loading，当前也可以父类关闭
            //暴露给子类的原因是，有些场景会用到
            //例如：请求失败后，在调用一个接口，如果中途关闭了
            //用户能看到多次显示loading，体验没那么好
        }
        else {
            //自动处理错误
            ExceptionHandleUtil.handlerResponse(baseResponse,error)
        }
    }
}

// MARK: - 扩展ObservableType
// 目的是添加两个自定义监听方法
// 一个是只观察请求成功的方法
// 一个既可以观察请求成功也可以观察请求失败
extension ObservableType {
    /// 观察成功和失败事件
    ///
    /// - Parameter onSuccess: <#onSuccess description#>
    /// - Returns: <#return value description#>
    func subscribe(_ success:@escaping ((Element)-> Void),_ error: @escaping ((BaseResponse?,Error?)-> Bool)) -> Disposable {
        //创建一个Disposable
        let disposable = Disposables.create()
        
        //创建一个HttpObserver
        let observer = HttpObserver<Element>(success,error)
        
        //创建并返回一个Disposables
        return Disposables.create(self.asObservable().subscribe(observer),disposable)
    }
    
    /// 观察成功的事件
    ///
    /// - Parameter onSuccess: <#onSuccess description#>
    /// - Returns: <#return value description#>
    func subscribeSuccess(_ controller:BaseLogicController?=nil, _ success:@escaping ((Element)-> Void) ) -> Disposable {
        let disposable = Disposables.create()
        
        let observer = HttpObserver<Element>(success,nil,controller)
        
        return Disposables.create(self.asObservable().subscribe(observer),disposable)
    }
}


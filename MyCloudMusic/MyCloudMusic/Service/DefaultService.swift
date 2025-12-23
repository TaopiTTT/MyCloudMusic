//
//  DefaultService.swift
//  网络API
//
//  Created by Tao on 2025/12/17.
//

import Foundation

//导入网络框架
import Moya

enum DefaultService {
    //广告列表
    case ads(position:Int)
    
    case sheets(size:Int)
    case sheetDetail(data:String)
    case createSheets(userId:String)
    case collectSheets(userId:String)
    case createSheet(data:Sheet)
    
    case register(data:User)
    case login(data:User)
    case resetPassword(data:User)
    
    case songs
    case songDetail(data:String)
    
    case userDetail(data:String,nickname:String?)
    
    case sendCode(style:Int,data:CodeRequest)
    case checkCode(data:CodeRequest)
    
    case comments(page:Int)
//    case createComment(data:Comment)
    
    case like(data:[String:Any])
    case cancelLike(style:Int,data:String)
    
    case videos(page:Int)
    case videoDetail(data:String)
    
    case feeds(userId:String?)
//    case createFeed(data:Feed)
    
    case follow(data:String)
    case cancelFollow(data:String)
    
    case friends(data:String)
    case fans(data:String)
    
    case addresses
    case addressDetail(data:String)
//    case createAddress(data:Address)
//    case updateAddress(id:String,data:Address)
    case deleteAddress(data:String)
//    case recognitionAddress(data:DataRequest)
    
//    case confirmOrder(data:OrderRequest)
//    case createOrder(data:OrderRequest)
    case orderDetail(data:String)
    case orders(status:Int)
//    case orderPay(id:String,data:PayRequest)
    
//    case addProductToCart(data:Cart)
    case carts
//    case editCart(id:String,data:Cart)
}

// MARK: - 实现TargetType协议
extension DefaultService:TargetType{
    /// 返回网址
    var baseURL: URL {
        return URL(string: Config.ENDPOINT)!
    }
    
    /// 返回每个请求的路径
    var path: String {
        switch self {
        case .ads(_):
            return "v1/ads"
            
        case .sheets, .createSheet:
            return "v1/sheets"
        case .sheetDetail(let data):
            return "v1/sheets/\(data)"
        case .createSheets(let userId):
            return "v1/users/\(userId)/create"
        case .collectSheets(let userId):
            return "v1/users/\(userId)/collect"
            
        case .songs:
            return "v1/songs"
        case .songDetail(let data):
            return "v1/songs/\(data)"
            
        case .register(_):
            return "v1/users"
            
        case .login:
            return "v1/sessions"
        case .resetPassword(_):
            return "v1/users/reset_password"
            
        case .userDetail(let data,_):
            return "v1/users/\(data)"
            
        case .sendCode:
            return "v1/codes"
        case .checkCode(_):
            return "v1/codes/check"
//            
//        case .comments, .createComment:
//            return "v1/comments"
            
        case .like:
            return "v1/likes"
        case .cancelLike(_, let data):
            return "v1/likes/\(data)"
            
        case .videos(_):
            return "v1/videos"
        case .videoDetail(let data):
            return "v1/videos/\(data)"
            
//        case .feeds(_), .createFeed(_):
//            return "v1/feeds"
            
        case .follow:
            return "v1/friends"
        case .cancelFollow(let data):
            return "v1/friends/\(data)"
            
        case .friends(let data):
            return "v1/users/\(data)/following"
        case .fans(let data):
            return "v1/users/\(data)/followers"
            
//        case .addresses, .createAddress:
//            return "v1/addresses"
//        case .addressDetail(let data):
//            return "v1/addresses/\(data)"
//        case .updateAddress(let id, let data):
//            return "v1/addresses/\(id)"
//        case .deleteAddress(let data):
//            return "v1/addresses/\(data)"
//        case .recognitionAddress(let data):
//            return "v1/nlp/address"
//            
//        case .confirmOrder:
//            return "v1/orders/confirm"
//        case .createOrder, .orders:
//            return "v1/orders"
//        case .orderDetail(let data):
//            return "v1/orders/\(data)"
//        case .orderPay(let id,let data):
//            return "v1/orders/\(id)/pay"
//            
//        case .addProductToCart, .carts:
//            return "v1/carts"
//        case .editCart(let id,let data):
//            return "v1/carts/\(id)"
            
        default:
            fatalError("DefaultService path is null")
        }
    }
    
    /// 请求方式
    var method: Moya.Method {
        switch self {
//        case .register, .login, .sendCode, .checkCode, .resetPassword, .createSheet, .createComment, .like, .createFeed, .follow, .createAddress, .recognitionAddress, .confirmOrder, .createOrder, .orderPay, .addProductToCart:
        case .register, .login, .sendCode, .checkCode, .resetPassword, .createSheet:
            return .post
        case .cancelLike, .cancelFollow, .deleteAddress:
            return .delete
            
//        case .updateAddress, .editCart:
//            return .patch
            
        default:
            return .get
        }
    }
    
    /// 请求的参数
    var task: Task {
        switch self {
        case .ads(let position):
            return ParamUtil.urlRequestParamters(["position":position])
        case .sheets(let size):
            return ParamUtil.urlRequestParamters(["size":size])
        case .createSheet(let data):
            return .requestData(data.toJSONString()!.data(using: .utf8)!)
            
        case .login(let data):
            return .requestData(data.toJSONString()!.data(using: .utf8)!)
        case .register(let data):
            return .requestData(data.toJSONString()!.data(using: .utf8)!)
        case .resetPassword(let data):
            return .requestData(data.toJSONString()!.data(using: .utf8)!)
            
        case .sendCode(let style, let data):
            return .requestCompositeParameters(bodyParameters: ["phone":data.phone,"email":data.email], bodyEncoding: JSONEncoding.default, urlParameters: ["style":style])
        case .checkCode(let data):
            return .requestData(data.toJSONString()!.data(using: .utf8)!)
            
        case .userDetail(_,let nickname):
            var param:[String:Any]=[:]
            
            if let nickname = nickname {
                param["nickname"]=nickname
            }
            return ParamUtil.urlRequestParamters(param)
            
//        case .comments(let page):
//            return ParamUtil.urlRequestParamters(["page":page])
//        case .createComment(let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
//            
//        case .like(let data):
//            return ParamUtil.jsonRequestParamters(data)
//        case .cancelLike(let style,_):
//            return ParamUtil.jsonRequestParamters(["style":style])
            
        case .feeds(let userId):
            if SuperStringUtil.isNotBlank(userId) {
                return ParamUtil.urlRequestParamters(["userId":userId])
            }
            
            return .requestPlain
//        case .createFeed(let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
            
//        case .follow(let data):
//            return ParamUtil.jsonRequestParamters(["id":data])
//            
//        case .createAddress(let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
//        case .updateAddress(_,let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
//        case .recognitionAddress(let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
//            
//        case .confirmOrder(let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
//        case .createOrder(let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
//        case .orders(let status):
//            return ParamUtil.urlRequestParamters(["status":status])
//        case .orderPay(_,let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
//            
//        case .addProductToCart(let data), .editCart(_,let data):
//            return .requestData(data.toJSONString()!.data(using: .utf8)!)
            
        default:
            //不传递任何参数
            return .requestPlain
        }
    }
    
    /// 请求头
    var headers: [String : String]? {
        var headers:Dictionary<String,String> = [:]
        
        //内容的类型
        headers["Content-Type"]="application/json"
        
        //判断是否登录了
        if PreferenceUtil.isLogin() {
            //获取token
            let session = PreferenceUtil.getSession()
            
            print("user session \(session)")
            
            //将token设置到请求头
            headers["Authorization"]=session
            
        }
        
        return headers
    }
    
    
}

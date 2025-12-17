//
//  DefaultService.swift
//  网络API
//
//  Created by Tao on 2025/12/17.
//

import Foundation

import Moya

enum DefaultService {
    //广告列表
    case ads(position:Int)
    
    case sheets(size:Int)
    case sheetDetail(data:String)
    case register(data:User)
}

extension DefaultService:TargetType{
    /// 返回网址
    var baseURL: URL {
        return URL(string: Config.ENDPOINT)!
    }
    
    var path: String {
        switch self {
        case .ads(_):
            return "v1/ads"
        case .sheets:
            return "v1/sheets"
        case .sheetDetail(let data):
            return "v1/sheets/\(data)"
        case .register(_):
            return "v1/users"
        default:
            fatalError("DefaultService path is null")
        }
    }
    
    
    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .ads(let position):
            return ParamUtil.urlRequestParamters(["position":position])
        case .sheets(let size):
            return ParamUtil.urlRequestParamters(["size":size])
            
        default:
            //不传递任何参数
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers:Dictionary<String,String> = [:]
        return headers
    }
    
}

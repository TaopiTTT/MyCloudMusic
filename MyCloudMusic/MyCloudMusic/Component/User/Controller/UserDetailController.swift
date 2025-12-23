//
//  UserDetailController.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/23.
//

import UIKit

class UserDetailController: BaseTitleController {
    var id:String!
    var nickname:String?
    
}

extension UserDetailController{
    /// 启动方法
    /// - Parameters:
    ///   - controller: <#controller description#>
    ///   - id: <#id description#>
    static func start(_ controller:UINavigationController,id:String="-1", nickname:String?=nil) {
        let target = UserDetailController()
        target.id=id
        target.nickname=nickname
        controller.pushViewController(target, animated: true)
    }
}

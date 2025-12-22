//
//  SuperUIViewControllerExtension.swift
//  对控制器扩展通用逻辑
//
//  Created by Tao on 2025/12/22.
//

import UIKit

extension UIViewController{
    /// 获取导航控制器
    func getNavigationController() -> UINavigationController {
        var nav = self.navigationController
        if let result = nav {
            return result
        }
        
        let rvc = UIApplication.shared.keyWindow!.rootViewController
        if rvc is UINavigationController {
            nav = rvc as! UINavigationController
        }else{
            nav = rvc!.navigationController
        }
        
        return nav!
    }
    
    //MARK: - 启动界面相关
    
    /// 启动界面
    func startController(_ data:UIViewController.Type) {
        let target = data.init()
        getNavigationController().pushViewController(target, animated: true)
    }
    
    
    func startController(_ data:UIViewController) {
        getNavigationController().pushViewController(data, animated: true)
    }
}


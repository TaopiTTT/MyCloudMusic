//
//  AppDelegate.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// 定义一个静态的计算属性
    /// 返回AppDelegate对象实例
    open class var shared:AppDelegate{
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller = SplashController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        
        return true
    }
    
    // 跳转到引导界面
    func toGuide() {
        let r = GuideController()
        setRootViewController(r)
    }
    
    // 跳转到主界面
    func toMain() {
        let r = MainController()
        setRootViewController(r)
    }
    
    func setRootViewController(_ data:UIViewController) {
        window!.rootViewController = data
    }
}


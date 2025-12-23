//
//  AppDelegate.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/12.
//

import UIKit
import SwiftEventBus

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
        
        initMMKV()
    
        let controller = SplashController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        
        
        if PreferenceUtil.isLogin() {
            //用户登录了，启动应用时，要初始化登录才能初始化的逻辑
            onLogin(nil)
        }
        
        return true
    }
    
    func initMMKV() {
        MMKV.initialize(rootDir: nil)
    }
    
    // 跳转到引导界面
    func toGuide() {
        let r = GuideController()
        setRootViewController(r)
    }
    
    /// 跳转到登录首页
    func toLogin() {
        toMain()
        
        //然后发送一个跳转到登录界面的通知，在发现界面处理
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(Constant.EVENT_LOGIN_CLICK), object: nil)
        }
    }
    
    /// 跳转到首页
    func toMain() {
        let r = MainController()
        let t = UINavigationController(rootViewController: r)
        setRootViewController(t)
    }
    
    func setRootViewController(_ data:UIViewController) {
        window!.rootViewController = data
    }
    
    func logout() {
        logoutSilence()
    }
    
    /// 静默退出
    func logoutSilence() {
        //清除登录相关信息
        PreferenceUtil.logout()
        
//        //第三方登录
//        ShareSDK.cancelAuthorize(.typeWechat, result: nil)
//        ShareSDK.cancelAuthorize(.typeQQ, result: nil)
//        
//        //退出聊天服务器
//        RCIMClient.shared().logout()
//        
//        DownloadManager.destroy()
        
        loginStatusChanged()
    }
    
    func onLogin(_ data:Session?) {
        
        if let navigationController = window?.rootViewController as? UINavigationController {
            //关闭登陆相关界面
            let vcs = navigationController.viewControllers
            
            var results:[UIViewController] = []
            for it in vcs {
                if it is LoginHomeController ||
                it is LoginController ||
                it is RegisterController
//                it is InputUserIdentityController ||
//                it is InputCodeController ||
//                it is SetPasswordController
                {
                    continue
                }
                
                results.append(it)
            }

            
            navigationController.setViewControllers(results, animated: true)
        }
        loginStatusChanged()
    }
    
    func loginStatusChanged() {
        SwiftEventBus.post(Constant.EVELT_LOGIN_STATUS_CHANGED)
    }
    
    
}


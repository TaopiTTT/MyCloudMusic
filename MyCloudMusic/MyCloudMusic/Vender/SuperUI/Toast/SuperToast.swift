//
//  SuperToast.swift
//  提示
//
//  Created by Tao on 2025/12/17.
//

import UIKit

class SuperToast {
    static var hud:MBProgressHUD?
    
    /// 显示提示
    /// - Parameter title: <#title description#>
    static func show(title:String) {
        let hud = MBProgressHUD.showAdded(to: AppDelegate.shared.window!.rootViewController!.view, animated: true)
        hud.mode = .text
        
        //背景颜色
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = .black
        
        //标题文字颜色
        hud.label.textColor = .colorLightWhite
        hud.label.font = UIFont.boldSystemFont(ofSize: 16)
        hud.label.numberOfLines = 0
        
        hud.label.text = title
        
        let offsetY = -hud.frame.height/CGFloat(2)+80
        
        //显示到屏幕顶部
        //因为显示到中心有点遮挡内容
        hud.offset = CGPoint(x: 0, y: offsetY)
        
        hud.removeFromSuperViewOnHide = true
        
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    /// 加载提示
    /// - Parameter title: <#title description#>
    static func showLoading(title:String = R.string.localizable.superLoading()) {
        //菊花颜色
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf:
            [MBProgressHUD.self]).color = .white
        
        if SuperToast.hud == nil {
            SuperToast.hud = MBProgressHUD.showAdded(to: AppDelegate.shared.window!.rootViewController!.view, animated: true)
            SuperToast.hud!.mode = .indeterminate
            
            //最小尺寸
            SuperToast.hud!.minSize = CGSize(width: 120, height: 120)
            
            //背景半透明
            SuperToast.hud!.backgroundView.style = .solidColor
            SuperToast.hud!.backgroundView.color = UIColor(white: 0, alpha: 0.5)
            
            //背景颜色
            SuperToast.hud!.bezelView.style = .solidColor
            SuperToast.hud!.bezelView.backgroundColor = .black
            
            //标题文字颜色
            SuperToast.hud!.label.textColor = .colorLightWhite
            SuperToast.hud!.label.font = UIFont.boldSystemFont(ofSize: TEXT_LARGE)
            
            //显示对话框
            SuperToast.hud!.show(animated: true)
        }
        
        //设置对话框文字
        SuperToast.hud!.label.text = title
        
        //详细文字
//        SuperToast.hud!.detailsLabel.text = "请耐心等待"
    }
    
    /// 隐藏提示
    static func hideLoading() {
        if let r = SuperToast.hud {
            r.hide(animated: true)
            SuperToast.hud = nil
        }
    }
}

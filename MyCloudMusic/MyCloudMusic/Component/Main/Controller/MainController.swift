//
//  MainController.swift
//  主界面
//
//  Created by Tao on 2025/12/15.
//

import UIKit
import SwiftEventBus

class MainController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //选中高亮颜色
        tabBar.tintColor = .primaryColor
        tabBar.isTranslucent = true
        
        //添加子控制器
        addChildController(DiscoveryController(), R.string.localizable.discovery(), "Discovery")
        addChildController(VideoController(), R.string.localizable.video(), "Video")
        addChildController(MeController(), R.string.localizable.me(), "Me")
        addChildController(FeedController(), R.string.localizable.feed(), "Feed")
        addChildController(RoomController(), R.string.localizable.live(), "Live")
        
        //点击事件，根据style区分具体是什么点击
        SwiftEventBus.onMainThread(self, name: Constant.CLICK_EVENT) { [weak self] sender in

            //获取发送过来的数据
            let data = sender?.object as! MyStyle

            self?.processClick(data)
        }
    }
    
    func processClick(_ data:MyStyle) {
        switch data {
        case .playList:
            listClick()
        default:
            break
        }
    }
    
    func listClick() {
        //创建一个View
        let contentView = PlayListView()
        
        //设置尺寸
        contentView.tg_width.equal(.fill)
        contentView.tg_height.equal(view.frame.height/1.5)
        
//        contentView.gk_size = CGSize(width: <#T##Double#>, height: <#T##Double#>)
        
        GKCover.cover(from: view, contentView: contentView, style: .translucent, showStyle: .bottom, showAnimStyle: .bottom, hideAnimStyle: .bottom, notClick: false)
    }
    
    /// 添加子控制器
    /// - Parameters:
    ///   - target: <#target description#>
    ///   - title: <#title description#>
    ///   - imageName: <#imageName description#>
    func addChildController(_ target:UIViewController,_ title:String,_ imageName:String) {
        //标题
        target.tabBarItem.title = title
        
        //默认图片
        target.tabBarItem.image = UIImage(named: imageName)
        
        //选择后图片
        target.tabBarItem.selectedImage = UIImage(named: "\(imageName)Selected")
        
        //选择后文本颜色
        target.tabBarItem.setBadgeTextAttributes([.foregroundColor:UIColor.colorPrimary], for: .selected)
        
        addChild(target)
    }
    
    /// 选择了，如果已经选择了，再次点击还会调用
    /// - Parameters:
    ///   - tabBar: <#tabBar description#>
    ///   - item: <#item description#>
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("MainController didSelectItem \(item.title!)")
    }
}

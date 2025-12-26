
//
//  BaseMainController.swift
//  通用控制器
//
//  Created by Tao on 2025/12/22.
//

import UIKit
import TangramKit
import SwiftEventBus

class BaseMainController: BaseMusicPlayerController {
    override func initViews() {
        super.initViews()
        setBackgroundColor(.colorBackgroundLight)
        
        addLeftImageButton(R.image.menu()!)
        addRightImageButton(R.image.mic()!)
        
        toolbarView.addCenterView(searchButton)
    }
    
    override func initListeners() {
        super.initListeners()
        // 注册导航栏手势驱动
        self.cw_registerShowIntractive(withEdgeGesture: false) { [weak self] direction in
            if direction == .fromLeft {
                self?.openDrawer()
            }
        }
        
        //注册播放列表改变了监听事件
        SwiftEventBus.onMainThread(self, name: Constant.EVENT_MUSIC_LIST_CHANGED) { [weak self] sender in
            self?.onMusicListChanged()
        }
        
    }
    
    override func leftClick(_ sender: QMUIButton) {
        openDrawer()
    }
    
    func openDrawer() {
        //真实内容滑动到外面
//        self.cw_showDefaultDrawerViewController(drawerController)
        
        //侧滑显示到真实内容上面
        self.cw_showDrawerViewController(drawerController, animationType: .mask, configuration: nil)
    }
    
    func closeDrawer() {
        dismiss(animated: true, completion: nil)
    }
    
    func onMusicListChanged() {
        let datum = MusicListManager.shared().datum
        if datum.count > 0 {
            if smallAudioControlPageView.superview == nil {
                //添加迷你播放控制器
                superFooterContentContainer.addSubview(smallAudioControlPageView)
            }
            
//            //显示播放数据
//            initPlayData()
//            
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//                //显示播放进度
//                self.showProgress()
//            }
//            
//            //显示播放状态
//            showMusicPlayStatus()
        } else {
            //隐藏迷你控制器
            smallAudioControlPageView.removeFromSuperview()
        }
    }
    
    /// 侧滑控制器
    lazy var drawerController: DrawerController = {
        let r = DrawerController()
        return r
    }()
    
    lazy var searchButton: QMUIButton = {
        let r = QMUIButton()
        r.tg_width.equal(SCREEN_WIDTH - 50 * 2)
        r.tg_height.equal(35)
        r.adjustsTitleTintColorAutomatically = true
        r.tintColor = .black80
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.corner(17.5)
        r.setTitle(R.string.localizable.hintSearchValue(), for: .normal)
        r.setTitleColor(.black80, for: .normal)
        r.backgroundColor = .colorDivider
        r.setImage(R.image.search()!.withTintColor(), for: .normal)
        r.imagePosition = .left
        r.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: PADDING_SMALL)
        r.addTarget(self, action: #selector(searchClick(_:)), for: .touchUpInside)
        return r
    }()
    
    lazy var smallAudioControlPageView: SmallAudioControlPageView = {
        let r = SmallAudioControlPageView()
        r.tg_width.equal(.fill)
        r.tg_height.equal(50)
        return r
    }()
    
    @objc func searchClick(_ sender:QMUIButton) {
        
    }
    
    
}

extension BaseMainController {
    /// 视图即将可见方法
    ///will：即将
    ///did：已经
    ///其他方法命名也都有这个规律
    /// - Parameter animated: <#animated description#>
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("BaseMainController viewWillAppear")
        
        onMusicListChanged()
    }
}

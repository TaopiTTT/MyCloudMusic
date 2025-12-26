
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
        
        //监听应用进入前台了
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //监听应用进入后台了
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
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
            
            //显示播放数据
            initPlayData()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                //显示播放进度
                self.showProgress()
            }
            
            //显示播放状态
            showMusicPlayStatus()
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
    
    // MARK: -搜索
    
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
    
    @objc func searchClick(_ sender:QMUIButton) {
        
    }
    
    // MARK: -音乐
    
    lazy var smallAudioControlPageView: SmallAudioControlPageView = {
        let r = SmallAudioControlPageView()
        r.tg_width.equal(.fill)
        r.tg_height.equal(50)
        
        //播放按钮点击，可以通过代理，block回调，但因为这些知识点已经讲解了，所以就直接设置
        r.playButtonView.addTarget(self, action: #selector(playClick(_:)), for: .touchUpInside)
        
        //列表按钮点击
        r.listButton.addTarget(self, action: #selector(listClick(_:)), for: .touchUpInside)
        
        //点击
        let tapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(smallAudioControlClick(_:)))
        r.addGestureRecognizer(tapGestureRecognizer)
        
        return r
    }()
    
    /// 迷你播放控制器点击
    @objc func smallAudioControlClick(_ gestureRecognizer:UITapGestureRecognizer) {
        startMusicPlayerController()
    }
    
    @objc func listClick(_ sender:QMUIButton) {
        SwiftEventBus.post(Constant.CLICK_EVENT,sender: MyStyle.playList)
    }
    
    @objc func playClick(_ sender:QMUIButton) {
        if MusicPlayerManager.shared().isPlaying() {
            MusicListManager.shared().pause()
        } else {
            MusicListManager.shared().resume()
        }
    }
    
    func setMusicPlayerDelegate() {
        MusicPlayerManager.shared().delegate = self
    }
    
    func removeMusicPlayerDelegate() {
        MusicPlayerManager.shared().delegate = nil
    }
    
    /// 进入前台了
    @objc func onEnterForeground() {
        initPlayData()
        
        setMusicPlayerDelegate()
    }
    
    /// 进入后台了
    @objc func onEnterBackground() {
        removeMusicPlayerDelegate()
    }
    
    /// 显示音乐时长
    func showDuration() {
        smallAudioControlPageView.duration=MusicListManager.shared().data!.duration
    }
    
    /// 选中当前播放的音乐
    func scrollPosition() {
        //获取当前音乐在播放列表中的索引
        let data = MusicListManager.shared().data!
        
        let datumOC = MusicListManager.shared().datum as NSArray
        let index = datumOC.index(of: data)
        
        if (index != -1) {
            //创建indexPath
            let indexPath = IndexPath(row: index, section: 0)
            
//            smallAudioControlPageView.scrollPosition(indexPath)
        }
    }
    
    func initPlayData() {
        smallAudioControlPageView.collectionView.reloadData()
        
        if MusicListManager.shared().data == nil {
            return
        }
        
        //显示音乐时长
        showDuration()
        
        scrollPosition()
        
        //显示歌词数据
//        showLyricData()
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
    
    /// 视图已经可见
    /// - Parameter animated: <#animated description#>
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("BaseMainController viewDidAppear")
        setMusicPlayerDelegate()
        
        //第一次获取消息数
//        messageCountChanged()
    }
    
    /// 视图即将消失
    /// - Parameter animated: <#animated description#>
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        print("BaseMainController viewWillDisappear")
    }
    
    /// 视图已经消失
    /// - Parameter animated: <#animated description#>
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        print("BaseMainController viewDidDisappear")
        removeMusicPlayerDelegate()
    }
    
    /// 显示播放状态
    func showMusicPlayStatus()  {
        if MusicPlayerManager.shared().isPlaying() {
            showPauseStatus()
        } else {
            showPlayStatus()
        }
    }
    
    /// 显示暂停状态
    func showPauseStatus() {
        smallAudioControlPageView.setPlaying(true)
    }
    
    /// 显示播放状态
    func showPlayStatus() {
        smallAudioControlPageView.setPlaying(false)
    }

    /// 显示播放进度
    func showProgress() {
        let progress=MusicListManager.shared().data!.progress
        let duration=MusicListManager.shared().data!.duration
        if duration>0 {
            smallAudioControlPageView.setProgress(progress)
        } else {
            smallAudioControlPageView.setProgress(0)
        }
    }
    
    
}

// MARK: - 播放管理器代理
extension BaseMainController:MusicPlayerManagerDelegate{
    func onPrepared(data: Song) {

        //显示时长
        showDuration()

        //选中当前音乐
        scrollPosition()
    }
    
    func onPaused(data: Song) {
        showPlayStatus()
    }
    
    func onPlaying(data: Song) {
        showPauseStatus()
    }
    
    func onProgress(data: Song) {
        showProgress()
    }
    
    func onLyricReady(data: Song) {
//        showLyricData()
    }

    func onError(data: Song) {
        
    }
}


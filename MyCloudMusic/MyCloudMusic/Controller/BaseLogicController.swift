//
//  BaseLogicController.swift
//  项目中通用的逻辑控制器
//
//  Created by Tao on 2025/12/14.
//

import UIKit
import TangramKit

class BaseLogicController: BaseCommonController {
    /// 根容器
    var rootContainer:TGBaseLayout!
    
    /// 头部容器
    var superHeaderContainer:TGBaseLayout!
    var superHeaderContentContainer:TGBaseLayout!
    
    /// 底部容器
    var superFooterContainer:TGBaseLayout!
    var superFooterContentContainer:TGBaseLayout!
    
    /// 容器
    var container:TGBaseLayout!
    
    /// TableView
    var tableView:UITableView!
    
    /// 滚动容器
    var scrollView:UIScrollView!
    
    /// 内容容器，一般只有初始化ScrollView后，才有效
    var contentContainer:TGBaseLayout!
    
    /// frame容器，一般用来添加占位布局
    var frameContainer:TGBaseLayout!
    
    lazy var datum: [Any] = {
        var result: [Any] = []
        return result
    }()

    
    /// 初始化RelativeLayout容器，四边都在安全区内
    func initRelativeLayoutSafeArea() {
        initLinearLayout()
        
        //header
        initHeaderContainer()
        
        container = TGRelativeLayout()
        container.tg_width.equal(.fill)
        container.tg_height.equal(.fill)
        container.backgroundColor = .clear
        rootContainer.addSubview(container)
        
        initFooterContainer()
    }
    
    /// 初始化垂直方向LinearLayout容器，四边都在安全区内
    func initLinearLayoutSafeArea() {
        initLinearLayout()
        
        //header
        initHeaderContainer()
        
        //frame
        frameContainer=TGRelativeLayout();
        frameContainer.tg_width.equal(.fill)
        frameContainer.tg_height.equal(.fill)
        frameContainer.backgroundColor = .clear
        rootContainer.addSubview(frameContainer)
        
        container = TGLinearLayout(.vert)
        container.tg_width.equal(.fill)
        container.tg_height.equal(.fill)
        container.backgroundColor = .clear
        frameContainer.addSubview(container)
        
        initFooterContainer()
    }
    
//    /// 初始化TableView，四边都在安全区内
//    func initTableViewSafeArea() {
//        //外面添加一层容器，是方便在真实内容控件前后添加内容
//        initLinearLayoutSafeArea()
//        
//        //tableView
//        createTableView()
//        
//        container.addSubview(tableView)
//    }
    
    /// 初始化ScrollView容器，四边都在安全区内
    func initScrollSafeArea() {
        initLinearLayoutSafeArea()
        
        //滚动容器
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.tg_width.equal(.fill)
        scrollView.tg_height.equal(.fill)
        container.addSubview(scrollView)
        
        //真实内容容器
        contentContainer = TGLinearLayout(.vert)
        contentContainer.tg_width.equal(.fill)
        contentContainer.tg_height.equal(.wrap)
        
        scrollView.addSubview(contentContainer)
    }
    
//    /// 在initLinearLayoutSafeArea基础上，设置padding，子控件间距
//    func initLinearLayoutInputSafeArea() {
//        initLinearLayoutSafeArea()
//        
//        container.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: 0, right: PADDING_OUTER)
//        container.tg_space = PADDING_OUTER
//    }
    
    /// 初始化垂直方向LinearLayout容器，只有顶部不在安全区
    func initLinearLayoutTopNotSafeArea() {
        rootContainer = TGRelativeLayout()
        rootContainer.tg_width.equal(.fill)
        rootContainer.tg_height.equal(.fill)
        rootContainer.backgroundColor = .clear
        self.view.addSubview(rootContainer)
        
        container=TGLinearLayout(.vert)
        container.tg_width.equal(.fill)
        container.tg_height.equal(.fill)
        container.backgroundColor = .clear
        container.tg_bottom.equal(TGLayoutPos.tg_safeAreaMargin)
        rootContainer.addSubview(container)
        
        //header
        initHeaderContainer()
    }
    
//    /// 创建TableView，不会添加到任何布局
//    func createTableView() {
//        tableView = ViewFactoryUtil.tableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
    
    /// 使用默认分割线
    func initDefaultTableViewDivider() {
        tableView.separatorStyle = .singleLine
    }
    
    /// 初始化垂直方向LinearLayout容器
    func initLinearLayout() {
        rootContainer = TGLinearLayout(.vert)
        rootContainer.tg_width.equal(.fill)
        rootContainer.tg_height.equal(.fill)
        rootContainer.backgroundColor = .clear
        view.addSubview(rootContainer)
    }
    
    /// 头部容器，安全区外，一般用来设置头部到安全区外背景颜色
    func initHeaderContainer() {
        superHeaderContainer = TGLinearLayout(.vert)
        superHeaderContainer.tg_width.equal(.fill)
        superHeaderContainer.tg_height.equal(.wrap)
        superHeaderContainer.backgroundColor = .clear
        
        //头部内容容器，安全区内
        superHeaderContentContainer = TGLinearLayout(.vert)
        superHeaderContentContainer.tg_height.equal(.wrap)
        superHeaderContentContainer.tg_leading.equal(TGLayoutPos.tg_safeAreaMargin)
        superHeaderContentContainer.tg_trailing.equal(TGLayoutPos.tg_safeAreaMargin)
        superHeaderContentContainer.tg_top.equal(TGLayoutPos.tg_safeAreaMargin)
        superHeaderContentContainer.backgroundColor = .clear
        
        superHeaderContainer.addSubview(superHeaderContentContainer)
        rootContainer.addSubview(superHeaderContainer)
    }
    
    func initFooterContainer() {
        superFooterContainer = TGLinearLayout(.vert)
        superFooterContainer.tg_width.equal(.fill)
        superFooterContainer.tg_height.equal(.wrap)
        superFooterContainer.backgroundColor = .clear
        
        //底部内容容器，安全区内
        superFooterContentContainer = TGLinearLayout(.vert)
        superFooterContentContainer.tg_height.equal(.wrap)
        superFooterContentContainer.tg_leading.equal(TGLayoutPos.tg_safeAreaMargin)
        superFooterContentContainer.tg_trailing.equal(TGLayoutPos.tg_safeAreaMargin)
        superFooterContentContainer.tg_bottom.equal(TGLayoutPos.tg_safeAreaMargin)
        superFooterContentContainer.backgroundColor = .clear
        
        superFooterContainer.addSubview(superFooterContentContainer)
        rootContainer.addSubview(superFooterContainer)
    }
    
    override func initViews() {
        super.initViews()
        
        //默认颜色，如果某些界面不一样，在单独设置
        setBackgroundColor(.colorBackground)
        
        //隐藏系统导航栏
        navigationController?.navigationBar.isHidden = true
    }

    /// 关闭界面
    func finish() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 隐藏键盘

    /// 点击空白隐藏键盘
    func initTapHideKeyboard() {
        //点击空白，关闭键盘
        let g=UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))

        //设置成false表示当前控件响应后会传播到其他控件上
        //如果不设置为false，界面里面的列表控件可能无法响应点击事件
        g.cancelsTouchesInView = true

        //将触摸事件添加到当前view
        view.addGestureRecognizer(g)
    }

    @objc func tapClick(_ data:UITapGestureRecognizer) {
        hideKeyboard()
    }

    /// 隐藏键盘
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    /// 设置状态栏为亮色(文字是白色)
    func setStatusBarLight() {
        
    }
    
    /// 标题容器设置为亮色，也是就是白天是白色
    func setHeaderLight() {
        superHeaderContainer.backgroundColor = .colorSurface
    }

    /// 底部容器设置为亮色，也是就是白天是白色
    func setFooterLight() {
        superFooterContainer.backgroundColor = .colorSurface
    }
    
//    /// 占位控件
//    lazy var placeholderView: PlaceholderView = {
//        let r = PlaceholderView()
//        r.hide()
//
//        frameContainer.addSubview(r)
//        
//        //添加点击事件
//        let g=UITapGestureRecognizer(target: self, action: #selector(placeholderViewClick(_:)))
//
//        //设置成false表示当前控件响应后会传播到其他控件上
//        //如果不设置为false，界面里面的列表控件可能无法响应点击事件
//        g.cancelsTouchesInView = false
//
//        r.addGestureRecognizer(g)
//
//        return r
//    }()
    
    /// 占位控件点击
    @objc func placeholderViewClick(_ recognizer:UITapGestureRecognizer) {
        loadData(true)
    }
    
    /// 加载数据方法
    /// - Parameter isPlaceholder: 是否是通过placeholder控件触发的
    func loadData(_ isPlaceholder:Bool=false) {
        
    }
    
    /// 关闭当前界面，并显示一个新界面
    func startControllerAndFinishThis(_ data:UIViewController) {
        let vcs = navigationController!.viewControllers
        
        var newVCS:[UIViewController] = []
        
        for (index,it) in vcs.enumerated(){
            if index != vcs.count - 1 {
                newVCS.append(it)
            }
        }

        newVCS.append(data)

        navigationController!.setViewControllers(newVCS, animated: true)
    }

}

//TableView数据源和代理
extension BaseLogicController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

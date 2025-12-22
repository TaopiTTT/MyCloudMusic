//
//  DrawerController.swift
//  首页侧滑控制器
//
//  Created by Tao on 2025/12/22.
//

import UIKit
import TangramKit
import DynamicColor

class DrawerController: BaseLogicController{
    override func initViews() {
        super.initViews()
        initScrollSafeArea()
        
        contentContainer.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
        
        //用户信息容器
        initUserView()
        
        initRecordView()
        initMessageMenu()
        initShopMenu()
        initOtherMenu()
        initAboutMenu()
        
    }
    
    //MARK: - 创建控件 用户
    func initUserView() {
        //头像那部分，因为这部分不会在应用其他位置使用，所以就不在封装到view中
        //当然真实项目中，如果为了更加方便管理，那也可以封装到单独view
        //相对容器
        let userContainer = TGRelativeLayout()
        userContainer.tg_width.equal(.fill)
        userContainer.tg_height.equal(.wrap)
        userContainer.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
        
        //点击
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userClick(_:)))
        userContainer.addGestureRecognizer(tapGestureRecognizer)
        
        //头像
        userContainer.addSubview(iconView)
        
        //昵称
        userContainer.addSubview(self.nicknameView)
        
        let moreView = ViewFactoryUtil.moreIconView()
        moreView.tg_leading.equal(self.nicknameView.tg_right).offset(3)
        userContainer.addSubview(moreView)
        
        //扫描按钮
        userContainer.addSubview(self.scanView)
        
        container.insertSubview(userContainer, at: 0)
        contentContainer.tg_space = PADDING_OUTER
    }
    
    @objc func userClick(_ data:UITapGestureRecognizer) {
        closeDrawer()
        startController(LoginHomeController.self)
    }
    
    lazy var iconView: UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(30)
        r.tg_height.equal(30)
        r.image = R.image.defaultAvatar()
        r.smallCorner()
        r.tg_centerY.equal(0)
        
        //图片从中心等比向外面填充，控件没有黑边，但图片可能被裁剪
        r.contentMode = .scaleAspectFill
        
        return r
    }()
    
    lazy var nicknameView: UILabel = {
        let result = UILabel()
        result.tg_width.equal(.wrap)
        result.tg_height.equal(.wrap)
        result.tg_centerY.equal(0)
        result.text = "昵称"
        result.font = UIFont.systemFont(ofSize: 16)
        result.textColor = .colorOnBackground
        result.tg_leading.equal(self.iconView.tg_right).offset(PADDING_MEDDLE)
        return result
    }()
    
    lazy var scanView: QMUIButton = {
        let result = ViewFactoryUtil.button(image:R.image.scan()!.withTintColor())
        result.tintColor = .colorOnBackground
        result.tg_centerY.equal(0)
        result.tg_right.equal(0)
        result.addTarget(self, action: #selector(scanClick(_:)), for: .touchUpInside)
        return result
    }()
    
    func closeDrawer() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func scanClick(_ data:UITapGestureRecognizer) {
        closeDrawer()
        
        #if targetEnvironment(simulator)
            SuperToast.show(title: "模拟器不支持该功能，请在运行到真机测试")
        #else
            startController(ScanController.self)
        #endif
    }
    
    //MARK: - 创建控件 黑胶唱片
    func initRecordView() {
        let recordContainer = TGLinearLayout(.vert)
        recordContainer.tg_width.equal(.fill)
        recordContainer.tg_height.equal(.wrap)
        recordContainer.backgroundColor = .black42
        recordContainer.corner()
        recordContainer.tg_padding = UIEdgeInsets(top: PADDING_MEDDLE, left: PADDING_MEDDLE, bottom: PADDING_MEDDLE, right: PADDING_MEDDLE)
        recordContainer.tg_space = PADDING_MEDDLE
        contentContainer.addSubview(recordContainer)
        
        //开通黑胶VIP，会员中心容器
        let vipContainer=TGRelativeLayout()
        vipContainer.tg_width.equal(.fill)
        vipContainer.tg_height.equal(.wrap)
        recordContainer.addSubview(vipContainer)
        
        //开通黑胶VIP
        let vipView = UILabel()
        vipView.tg_width.equal(.wrap)
        vipView.tg_height.equal(.wrap)
        vipView.text = R.string.localizable.buyVip()
        vipView.font = UIFont.systemFont(ofSize:TEXT_MEDDLE)
        vipView.textColor = .black183
        vipView.tg_centerY.equal(0)
        vipContainer.addSubview(vipView)
        
        //会员中心按钮
        let memberView = ViewFactoryUtil.secondHalfFilletSmallButton()
        memberView.setTitle(R.string.localizable.memberCenter(), for: .normal)
        memberView.setTitleColor(DynamicColor(hex: 0x837774), for: .normal)
        memberView.qmui_borderWidth = 1
        memberView.qmui_borderColor = .vipBorder
        memberView.tg_centerY.equal(0)
        memberView.tg_right.equal(0)
        vipContainer.addSubview(memberView)
        
        //加入黑胶vip提示
        let vipHintView = UILabel()
        vipHintView.tg_width.equal(.wrap)
        vipHintView.tg_height.equal(.wrap)
        vipHintView.text = R.string.localizable.vipHint()
        vipHintView.font = UIFont.systemFont(ofSize: 12)
        vipHintView.textColor = .vipBorder
        recordContainer.addSubview(vipHintView)
        
        //分割线
        let divderView = ViewFactoryUtil.smallDivider()
        divderView.backgroundColor = .divider2
        recordContainer.addSubview(divderView)
        
        //价格提示
        let priceHintView = UILabel()
        priceHintView.tg_width.equal(.wrap)
        priceHintView.tg_height.equal(.wrap)
        priceHintView.text = R.string.localizable.vipHintPrice()
        priceHintView.font = UIFont.systemFont(ofSize: 12)
        priceHintView.textColor = .vipBorder
        recordContainer.addSubview(priceHintView)
    }
    
    //MARK: - 创建控件 我的消息
    func initMessageMenu() {
        let itemContainer=TGLinearLayout(.vert)
        itemContainer.tg_width.equal(.fill)
        itemContainer.tg_height.equal(.wrap)
        itemContainer.backgroundColor = .colorDivider
        itemContainer.corner()
        itemContainer.tg_space = PADDING_MIN
        contentContainer.addSubview(itemContainer)
        
        //我的消息
        itemContainer.addSubview(self.messgeView)
        
        //我的好友
        var itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myFriend()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                guard let self = self else { return }
//                UserController.start(self.getNavigationController(), .friend)
//            }
        }
        
        itemContainer.addSubview(itemView)
        
        //我的粉丝
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myFans()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                guard let self = self else { return }
//                UserController.start(self.getNavigationController(), .fans)
//            }
        }
        itemContainer.addSubview(itemView)
        
        //二维码
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myCode()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                guard let self = self else { return }
//                self.getNavigationController().startController(CodeController.self)
//            }
        }
        itemContainer.addSubview(itemView)
    }
    
    lazy var messgeView: SuperSettingView = {
        let result=SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myMessage()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter({
//                guard let self = self else { return }
//                self.startController(ConversationController.self)
//            })
        }
        
        //设置红点偏移
        result.titleView.qmui_badgeOffset = CGPoint(x: 1, y: 19)
        
        return result
    }()
    
    
    //MARK: - 创建控件 商城
    func initShopMenu() {
        let itemContainer=TGLinearLayout(.vert)
        itemContainer.tg_width.equal(.fill)
        itemContainer.tg_height.equal(.wrap)
        itemContainer.backgroundColor = .colorDivider
        itemContainer.corner()
        itemContainer.tg_space = 0.5
        contentContainer.addSubview(itemContainer)
        
        //商城
        var itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.mall()) {[weak self] data in
            self?.closeDrawer()
//            self?.startController(ProductController.self)
        }
        itemContainer.addSubview(itemView)
        
        //我的订单
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myOrder()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                self?.startController(OrderController.self)
//            }
        }
        itemContainer.addSubview(itemView)
        
        //购物车
        itemView = SuperSettingView.smallWithIcon(icon: R.image.shopCart()!, title: R.string.localizable.shopCart()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                self?.startController(CartController.self)
//            }
        }
        itemContainer.addSubview(itemView)
        
        //收货地址
        itemView = SuperSettingView.smallWithIcon(icon: R.image.shopCart()!, title: R.string.localizable.receivingAddress()) {[weak self] data in
            self?.closeDrawer()
//            self?.loginAfter {
//                self?.startController(AddressController.self)
//            }
        }
        itemContainer.addSubview(itemView)
    }
    
    //MARK: - 创建控件 其他
    func initOtherMenu() {
        let itemContainer=TGLinearLayout(.vert)
        itemContainer.tg_width.equal(.fill)
        itemContainer.tg_height.equal(.wrap)
        itemContainer.backgroundColor = .colorDivider
        itemContainer.corner()
        itemContainer.tg_space = 0.5
        contentContainer.addSubview(itemContainer)
        
        //标题
        let groupTitle = QMUILabel()
        groupTitle.tg_width.equal(.fill)
        groupTitle.tg_height.equal(.wrap)
        groupTitle.contentEdgeInsets = UIEdgeInsets(top: PADDING_MEDDLE, left: PADDING_OUTER, bottom: PADDING_MEDDLE, right: PADDING_OUTER)
        groupTitle.textColor = .black80
        groupTitle.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        groupTitle.backgroundColor = .colorSurface
        groupTitle.text = R.string.localizable.other()
        itemContainer.addSubview(groupTitle)
        
        //设置
        var itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.setting()) {[weak self] data in
            self?.closeDrawer()
//            self?.startController(SettingController.self)
        }
        itemContainer.addSubview(itemView)
        
        //深色模式
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.darkMode(),click:{[weak self] data in
            
        },switchChanged: { data in
            print("night switch changed \(data.isOn)")
        })
        itemContainer.addSubview(itemView)
        
        //定时关闭
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.timedOff()) {[weak self] data in
            self?.closeDrawer()
            
        }
        itemView.moreView.text = R.string.localizable.notOpen()
        itemContainer.addSubview(itemView)
        
        //个性装扮
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.personDress()) {[weak self] data in
            self?.closeDrawer()
            
        }
        itemContainer.addSubview(itemView)

        
        //边听边缓存
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.cacheWhileList()) {[weak self] data in
            self?.closeDrawer()
            
        }
        itemContainer.addSubview(itemView)

        
        //音乐闹钟
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.musicAlarmClock()) {[weak self] data in
            self?.closeDrawer()
            
        }
        itemContainer.addSubview(itemView)
    }
    
    //MARK: - 创建控件 关于
    func initAboutMenu() {
        let itemContainer=TGLinearLayout(.vert)
        itemContainer.tg_width.equal(.fill)
        itemContainer.tg_height.equal(.wrap)
        itemContainer.backgroundColor = .colorDivider
        itemContainer.corner()
        itemContainer.tg_space = 0.5
        contentContainer.addSubview(itemContainer)

        //我的客服
        var itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.myCustomerService()) {[weak self] data in
            self?.closeDrawer()
            
        }
        itemContainer.addSubview(itemView)
        
        //分享
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.shareApp()) {[weak self] data in
            self?.closeDrawer()
            
        }
        itemContainer.addSubview(itemView)
        
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title:"接口签名和加密") {[weak self] data in
            self?.closeDrawer()
        }
        itemContainer.addSubview(itemView)
        
        //关于
        itemView = SuperSettingView.smallWithIcon(icon: R.image.scan()!, title: R.string.localizable.about()) {[weak self] data in
            self?.closeDrawer()
            
        }
        itemContainer.addSubview(itemView)
    }
}

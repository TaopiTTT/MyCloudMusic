//
//  GuideController.swift
//  引导界面
//
//  Created by Tao on 2025/12/15.
//

import UIKit
import TangramKit


class GuideController: BaseLogicController {

    override func initViews() {
        super.initViews()
        initLinearLayoutSafeArea()
        
        //按钮容器
        let controlContainer = TGLinearLayout(.horz)
        controlContainer.tg_bottom.equal(PADDING_OUTER)
        controlContainer.tg_width ~= .fill
        controlContainer.tg_height.equal(.wrap)
        
        //水平拉升，左，中，右间距一样
        controlContainer.tg_gravity = TGGravity.horz.among
        container.addSubview(controlContainer)
        
        //登录注册按钮
        let primaryButton = ViewFactoryUtil.primaryButton()
        primaryButton.setTitle(R.string.localizable.loginOrRegister(), for: .normal)
        primaryButton.addTarget(self, action: #selector(primaryClick(_:)), for: .touchUpInside)
        primaryButton.tg_width.equal(BUTTON_WIDTH_MEDDLE)
        controlContainer.addSubview(primaryButton)
        
        //立即体验按钮
        let enterButton = ViewFactoryUtil.primaryOutlineButton()
        enterButton.setTitle(R.string.localizable.experienceNow(), for: .normal)
        enterButton.addTarget(self, action: #selector(enterClick(_:)), for: .touchUpInside)
        enterButton.tg_width.equal(BUTTON_WIDTH_MEDDLE)
        controlContainer.addSubview(enterButton)
    }
    
    ///登录注册按钮点击
    /// - Parameter sender: <#sender description#>
    @objc func primaryClick(_ sender:QMUIButton) {
//        AppDelegate.shared.toLogin()
    }
    
    ///立即体验按钮点击
    /// - Parameter sender: <#sender description#>
    @objc func enterClick(_ sender:QMUIButton) {
        AppDelegate.shared.toMain()
    }
    
}

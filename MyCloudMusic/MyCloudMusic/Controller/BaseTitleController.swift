//
//  BaseTitleController.swift
//  标题控制器
//
//  Created by Tao on 2025/12/14.
//

import UIKit

class BaseTitleController: BaseLogicController {
    override func initLinearLayoutSafeArea() {
        super.initLinearLayoutSafeArea()
        prepareInitToolbar()
    }
    
    override func initRelativeLayoutSafeArea() {
        super.initRelativeLayoutSafeArea()
        prepareInitToolbar()
    }
    
    func prepareInitToolbar() {
        if isAddToolBar() {
            initToolbar()
        }
    }
    
    override var title: String?{
        didSet {
            toolbarView.titleView.text = title
        }
    }
    
    /// 是否添加toolbar
    func isAddToolBar() -> Bool {
        return true
    }
    
    func initToolbar() {
        superHeaderContentContainer.addSubview(toolbarView)
        
        //添加返回按钮
        if navigationController?.viewControllers.count != 1 {
            let r = addLeftImageButton(R.image.arrowLeft()!.withTintColor())
            r.tag = VALUE10
        }
    }
    
    /// 状态栏，导航栏字体白色
    func setToolbarLight() {
        self.toolbarView.setToolbarLight()
    }
    
    @discardableResult
    /// 添加左侧图片按钮
    /// - Parameter data: <#data description#>
    func addLeftImageButton(_ data:UIImage) -> QMUIButton {
        let leftButton=ViewFactoryUtil.button(image: data)
        leftButton.addTarget(self, action: #selector(leftClick(_:)), for: .touchUpInside)
        toolbarView.addLeftItem(leftButton)
        return leftButton
    }
    
    /// 添加右侧图片按钮
    func addRightImageButton(_ data:UIImage) {
        let rightButton = ViewFactoryUtil.button(image: data)
        rightButton.addTarget(self, action: #selector(rightClick(_:)), for: .touchUpInside)
        toolbarView.addRightItem(rightButton)
    }
    
    @discardableResult
    /// 添加右侧按钮
    /// - Parameter data: <#data description#>
    func addRightButton(_ data:String) -> QMUIButton{
        let rightButton = ViewFactoryUtil.linkButton()
        rightButton.setTitle(data, for: .normal)
        rightButton.setTitleColor(.colorOnSurface, for: .normal)
        rightButton.addTarget(self, action: #selector(rightClick(_:)), for: .touchUpInside)
        rightButton.sizeToFit()
        toolbarView.addRightItem(rightButton)
        return rightButton
    }
    
    /// 左侧按钮点击方法
    /// - Parameter sender: <#sender description#>
    @objc func leftClick(_ sender:QMUIButton) {
        if sender.tag == VALUE10 {
            navigationController?.popViewController(animated: true)
        }
    }
    
    /// 右侧按钮点击方法
    /// - Parameter sender: <#sender description#>
    @objc func rightClick(_ sender:QMUIButton) {
    }
    
    lazy var toolbarView: SuperToolbarView = {
        let r = SuperToolbarView()
        return r
    }()
}

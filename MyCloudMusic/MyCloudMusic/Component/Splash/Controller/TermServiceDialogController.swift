//
//  TermServiceDialogController.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/14.
//

import UIKit
import TangramKit

class TermServiceDialogController: BaseController, QMUIModalPresentationContentViewControllerProtocol {
    var contentContainer:TGBaseLayout!
    var modalController:QMUIModalPresentationViewController!
    var textView:UITextView!
    var disagreeButton:QMUIButton!
    
    override func initViews() {
        super.initViews()
        view.layer.cornerRadius = MEDDLE_RADIUS
        view.clipsToBounds = true
        view.backgroundColor = .colorDivider
        view.tg_width.equal(.fill)
        view.tg_height.equal(.wrap)
        
        //内容容器
        contentContainer = TGLinearLayout(.vert)
        contentContainer.tg_width.equal(.fill)
        contentContainer.tg_height.equal(.wrap)
        contentContainer.tg_space = 25
        contentContainer.backgroundColor = .colorBackground
        contentContainer.tg_padding = UIEdgeInsets(top: PADDING_LARGE2, left: PADDING_LARGE2, bottom: PADDING_LARGE2, right: PADDING_LARGE2)
        contentContainer.tg_gravity = TGGravity.horz.center
        view.addSubview(contentContainer)
        
        //标题
        contentContainer.addSubview(titleView)
        
        textView = UITextView()
        textView.tg_width.equal(.fill)
        
        //超出的内容，自动支持滚动
        textView.tg_height.equal(230)
        textView.text="公司CFO David Wehner也在财报中给出了眼下正在面临的一系列增长压力。Wehner透露，目前各个内容平台对消费者使用时间的竞争正在加剧。即便是在公司内部的产品线中，消费者的粘性也呈现向Reels这样的视频界面转移的倾向，但该功能的货币转化率要低于信息流等传统文字业务。此外，META也预期苹果的iOS系统规则变更和监管带来的变化将继续对定向广告业务带来负面影响，同时实体经济中的通胀和供应链问题也会影响广告主的预算。此外在美联储加息周期中，外汇（美元对其他货币升值）也将成为公司营收增长的负面因素。作为Facebook的母公司，Meta Platforms Inc.第四季度用户增长陷入停滞，并且本季度展望令人失望，引发了对于该公司未来增长前景的担忧，该公司最终可能难以证明对元宇宙（首席执行官扎克伯格的沉浸式互联网愿景）的昂贵押注是合理的公司CFO David Wehner也在财报中给出了眼下正在面临的一系列增长压力。Wehner透露，目前各个内容平台对消费者使用时间的竞争正在加剧。即便是在公司内部的产品线中，消费者的粘性也呈现向Reels这样的视频界面转移的倾向，但该功能的货币转化率要低于信息流等传统文字业务。此外，META也预期苹果的iOS系统规则变更和监管带来的变化将继续对定向广告业务带来负面影响，同时实体经济中的通胀和供应链问题也会影响广告主的预算。此外在美联储加息周期中，外汇（美元对其他货币升值）也将成为公司营收增长的负面因素。作为Facebook的母公司，Meta Platforms Inc.第四季度用户增长陷入停滞，并且本季度展望令人失望，引发了对于该公司未来增长前景的担忧，该公司最终可能难以证明对元宇宙（首席执行官扎克伯格的沉浸式互联网愿景）的昂贵押注是合理的"
        
        textView.backgroundColor = .clear
        
        //禁用编辑
        textView.isEditable = false
        
        contentContainer.addSubview(textView)
        
        contentContainer.addSubview(primaryButton)
        
        //不同意按钮按钮
        disagreeButton=ViewFactoryUtil.linkButton()
        disagreeButton.setTitle(R.string.localizable.disagree(), for: .normal)
        disagreeButton.setTitleColor(.black80, for: .normal)
        disagreeButton.addTarget(self, action: #selector(disagreeClick(_:)), for: .touchUpInside)
        disagreeButton.sizeToFit()
        contentContainer.addSubview(disagreeButton)
    }
    
    @objc func disagreeClick(_ sender:QMUIButton) {
        hide()
        
        //退出应用
        exit(0)
    }
    
    func show() {
        modalController = QMUIModalPresentationViewController()
        modalController.animationStyle = .fade
        
        //边距
        modalController.contentViewMargins = UIEdgeInsets(top: PADDING_LARGE2, left: PADDING_LARGE2, bottom: PADDING_LARGE2, right: PADDING_LARGE2)
        
        //点击外部不隐藏
        modalController.isModal = true
        
        //设置要显示的内容控件
        modalController.contentViewController = self
        
        modalController.showWith(animated: true)
    }
    
    func hide() {
        modalController.hideWith(animated: true, completion: nil)
    }
    
    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.text = "标题"
        r.textColor = .colorOnSurface
        r.font = UIFont.boldSystemFont(ofSize: TEXT_LARGE2)
        r.textAlignment = .center
        return r
    }()
    
    lazy var primaryButton: QMUIButton = {
        let r = ViewFactoryUtil.primaryHalfFilletButton()
        r.setTitle(R.string.localizable.agree(), for: .normal)
        return r
    }()

}

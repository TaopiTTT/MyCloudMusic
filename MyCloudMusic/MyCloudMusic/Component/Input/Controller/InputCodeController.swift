//
//  InputCodeController.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/23.
//

import UIKit
import TangramKit
import MHVerifyCodeView

class InputCodeController: BaseLoginController {
    var pageData:InputCodePageData!
    var codeStyle:Int!
    var codeRequest:CodeRequest!
    
    override func initViews() {
        super.initViews()
        setBackgroundColor(.colorLightWhite)
        
        initLinearLayoutInputSafeArea()
        
        container.tg_padding = UIEdgeInsets(top: PADDING_LARGE2, left: PADDING_LARGE2, bottom: PADDING_LARGE2, right: PADDING_LARGE2)
        
        container.tg_gravity = TGGravity.horz.right
        
        //请输入验证码标题
        let inputTitleView = UILabel()
        inputTitleView.tg_width.equal(.fill)
        inputTitleView.tg_height.equal(.wrap)
        inputTitleView.text=R.string.localizable.verificationCode()
        inputTitleView.font = UIFont.systemFont(ofSize: TEXT_LARGE4)
        inputTitleView.textColor = .colorOnSurface
        container.addSubview(inputTitleView)
        
        //提示
        container.addSubview(codeSendTargetView)
        
        //验证码输入框
        container.addSubview(codeInputView)
        
        //重新发送按钮
        container.addSubview(sendView)
    }
    
    override func initDatum() {
        super.initDatum()
        //显示验证码发送到目标
        var target:String!
        codeRequest = CodeRequest()
        if SuperStringUtil.isNotBlank(pageData.phone) {
            target = pageData.phone
            codeStyle = VALUE10
            codeRequest.phone = pageData.phone
        } else {
            target = pageData.email
            codeStyle = VALUE0
            codeRequest.email = pageData.email
        }
        codeSendTargetView.text = R.string.localizable.verificationCodeSentTo(target)
        
        sendCode()
    }
    
    func processNext(_ data:String) {
        if pageData.style == .phoneLogin {
            //手机号验证码登录
            let param = User()
            param.phone=pageData.phone
            param.email=pageData.email
            param.code=data
            login(param)
        } else {
            //先校验验证码
            codeRequest.code = data

            DefaultRepository.shared
                .checkCode(codeRequest)
                .subscribe({ result in
                    //重设密码
                    SetPasswordController.start(self.navigationController!, self.codeRequest)
                }, { response, error in
                    //清除验证码输入的内容
                    //self.codeInputView.clear
                    return false
                }).disposed(by: rx.disposeBag)
        }
    }
    
    @objc func sendClick(_ sender:QMUIButton) {
        sendCode()
    }
    
    func sendCode() {
        DefaultRepository.shared
            .sendCode(codeStyle, codeRequest)
            .subscribeSuccess {[weak self] data in
                //发送成功了

                //开始倒计时
                self?.startCountDown()
            }.disposed(by: rx.disposeBag)
    }
    
    /// 开始倒计时
    func startCountDown() {
            CountDownUtil.countDown(60) { result in
            
            if result == 0 {
                self.sendView.setTitle(R.string.localizable.resend(), for: .normal)
                self.sendView.isEnabled = true
            } else {
                self.sendView.setTitle(R.string.localizable.resendCount(result), for: .normal)
            }
            
            self.sendView.sizeToFit()
        }
        
        //禁用按钮
        self.sendView.isEnabled = false
    }
    
    lazy var sendView: QMUIButton = {
        let r = ViewFactoryUtil.linkButton()
        r.setTitleColor(.black80, for: .normal)
        r.addTarget(self, action: #selector(sendClick(_:)), for: .touchUpInside)
        r.setTitle(R.string.localizable.resend(), for: .normal)
        r.sizeToFit()
        return r
    }()
    
    lazy var codeSendTargetView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.textColor = .colorOnSurface
        
        return r
    }()
    
    lazy var codeInputView: MHVerifyCodeView = {
        let r = MHVerifyCodeView.init()
        r.tg_width.equal(.fill)
        r.tg_height.equal(50)
        r.spacing = 10
        r.verifyCount = 6
        r.setCompleteHandler { (result) in
            self.processNext(result)
        }
        return r
    }()
}

extension InputCodeController{
    static func start(_ controller:UINavigationController,_ data:InputCodePageData) {
        let target = InputCodeController()
        target.pageData=data
        controller.pushViewController(target, animated: true)
    }
}

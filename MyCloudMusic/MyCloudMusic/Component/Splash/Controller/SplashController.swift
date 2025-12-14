//
//  SplashViewController.swift
//  启动界面    
//
//  Created by Tao on 2025/12/13.
//

import UIKit
import TangramKit

class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 创建一个相对容器
        let container = TGRelativeLayout()
        
        //从安全区开始
        container.tg_top.equal(TGLayoutPos.tg_safeAreaMargin)
        container.tg_leading.equal(TGLayoutPos.tg_safeAreaMargin)
        container.tg_trailing.equal(TGLayoutPos.tg_safeAreaMargin)
        container.tg_bottom.equal(TGLayoutPos.tg_safeAreaMargin)
//        container.backgroundColor = .gray
        view.addSubview(container)
        
        // banner
        let bannerView = UIImageView()
        bannerView.tg_width.equal(75)
        bannerView.tg_height.equal(309)
        bannerView.tg_top.equal(120)
        bannerView.tg_centerX.equal(0)
        bannerView.image = R.image.splashBanner()
        container.addSubview(bannerView)
        
        // 版权
        let copyrightView = UILabel()
        copyrightView.tg_width.equal(.wrap)
        copyrightView.tg_height.equal(.wrap)
        copyrightView.tg_bottom.equal(16)
        copyrightView.tg_centerX.equal(0)
        copyrightView.font = UIFont.systemFont(ofSize: 12)
        copyrightView.textColor = .gray
        let year = SuperDateUtil.currentYear()
        copyrightView.text = String(format: "Copyright © %d TaopiTTT. All Rights Reserved.", year)
        container.addSubview(copyrightView)
        
        // LOGO
        let logoView = UIImageView(image: R.image.splashLogo())
        logoView.tg_width.equal(188)
        logoView.tg_height.equal(31)
        logoView.tg_bottom.equal(copyrightView.tg_top).offset(16)
        logoView.tg_centerX.equal(0)
        logoView.contentMode = .scaleAspectFill
        container.addSubview(logoView)

    }
    
}

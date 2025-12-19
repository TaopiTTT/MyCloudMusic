//
//  DiscoveryButtonCell.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/19.
//

import UIKit
import TangramKit

class DiscoveryButtonCell: BaseTableViewCell {
    static let NAME = "DiscoveryButtonCell"

    override func initViews() {
        super.initViews()
        container.addSubview(scrollView)
    }
    
    func bind(_ data:ButtonData) {
        if contentContainer.subviews.count > 0 {
            return
        }
        
        let containerWidth=(UIScreen.main.bounds.width-10*2)/5.5
        for it in data.datum {
            let buttonView = DiscoveryButtonView()
            buttonView.tg_width.equal(containerWidth)
            buttonView.bind(it.title,it.icon)
            
            if it.title == R.string.localizable.dayRecommend() {
                //显示日期
                buttonView.tipView.text = "\(SuperDateUtil.currentDay())"
            }
            
            //设置点击事件
            
            contentContainer.addSubview(buttonView)
        }
    }

    lazy var scrollView: UIScrollView = {
        let r = UIScrollView()
        r.contentInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        r.showsHorizontalScrollIndicator = false
        r.tg_width.equal(.fill)
        r.tg_height.equal(100)
        
        //真实内容容器
        r.addSubview(self.contentContainer)
        
        return r
    }()
    
    lazy var contentContainer: TGBaseLayout = {
        let r = TGLinearLayout(.horz)
        r.tg_width.equal(.wrap)
        r.tg_height.equal(100)
        r.tg_gravity = TGGravity.vert.center
        return r
    }()
}


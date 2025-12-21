//
//  SheetCell.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/21.
//

import UIKit
import TangramKit

class SheetCell: BaseCollectionViewCell {
    override func initViews() {
        super.initViews()
        container.tg_space = PADDING_SMALL
        
        container.addSubview(iconView)
        container.addSubview(titleView)
    }
    
    func bind(_ data:Sheet) {
//        if let r = data.icon {
//            let r = ResourceUtil.resourceUri(r)
//            iconView.sd_setImage(with: URL(string: r), placeholderImage: R.image.placeholder())
//        }
        iconView.show(data.icon)
        
        titleView.text = data.title
    }
    
    lazy var iconView: UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(.fill)
        r.tg_height.equal(r.tg_width)
        r.image = R.image.placeholder()
        
        //图片从中心等比向外面填充，控件没有黑边，但图片可能被裁剪
        r.contentMode = .scaleAspectFill
        
        //小圆角
        r.smallCorner()
        
        return r
    }()
    
    /// 标题
    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 2
        r.font = UIFont.systemFont(ofSize:TEXT_MEDDLE)
        r.textColor = .colorOnSurface
        
        return r
    }()
}


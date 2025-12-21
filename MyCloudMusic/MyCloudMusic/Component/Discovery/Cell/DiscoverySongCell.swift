//
//  DiscoverySongCell.swift
//  发现界面单曲Cell
//
//  Created by Tao on 2025/12/21.
//

import UIKit
import TangramKit

class DiscoverySongCell: BaseTableViewCell {
    static let NAME = "DiscoverySongCell"
    
    override func initViews() {
        super.initViews()
        container.tg_space = PADDING_MEDDLE
        container.tg_gravity = TGGravity.vert.center
        
        container.addSubview(iconView)
        container.addSubview(rightContainer)
        
        rightContainer.addSubview(titleView)
        rightContainer.addSubview(infoView)
    }
    
    func bind(_ data:Song) {
        //TODO Bug用这个框架显示,会导致Item高度不正确,暂时还不知道具体是什么问题
//        iconView.show(data.icon)
        
        iconView.sd_setImage(with: URL(string: data.icon!.absoluteUri()), placeholderImage: R.image.placeholder())
        
        titleView.text = data.title
        
        //专辑和歌单差不多，这里就不在实现了
        infoView.text = "\(data.singer.nickname!)-这是专辑名称"
    }
    
    lazy var iconView: UIImageView = {
        let result=UIImageView()
        result.tg_width.equal(51)
        result.tg_height.equal(51)
        result.image = R.image.dayRecommend()
        result.clipsToBounds=true
        
        result.contentMode = .scaleAspectFill
        
        result.smallCorner()
        return result
    }()
    
    lazy var rightContainer: TGLinearLayout = {
        let result=TGLinearLayout(.vert)
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        
        result.tg_space = PADDING_SMALL
        return result
    }()
    
    /// 标题控件
    lazy var titleView: UILabel = {
        let result=UILabel()
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 14)
        result.textColor = .colorOnSurface
        return result
    }()
    
    lazy var infoView: UILabel = {
        let result=UILabel()
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        result.font = UIFont.systemFont(ofSize: 12)
        result.textColor = .black80
        return result
    }()
}

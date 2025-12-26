//
//  SongSmallCell.swift
//  迷你音乐控制器cell
//
//  Created by Tao on 2025/12/26.
//

import UIKit
import TangramKit

class SongSmallCell: BaseCollectionViewCell {
    override func initViews() {
        super.initViews()
        container.tg_leftPadding = PADDING_OUTER
        container.tg_rightPadding = PADDING_OUTER
        container.tg_height.equal(.fill)
        container.tg_space = PADDING_SMALL
        container.tg_gravity = TGGravity.vert.center
        
        container.addSubview(self.iconView)
        
        container.addSubview(self.rightContainer)
        rightContainer.addSubview(self.titleView)
        
//        //歌词
//        rightContainer.addSubview(lineView)
    }
    
    func bind(_ data:Song) {
        iconView.show2(data.icon)
        titleView.text = data.title
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .horz
    }
    
    lazy var iconView: UIImageView = {
        let r = UIImageView()
        r.tg_width.equal(35)
        r.tg_height.equal(35)
        r.contentMode = .scaleAspectFill
        r.smallCorner()
        return r
    }()
    
    lazy var rightContainer: TGLinearLayout = {
        let r = TGLinearLayout(.vert)
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.tg_space = PADDING_SMALL
        r.smallCorner()
        return r
    }()
    
    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 1
        r.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        r.textColor = .colorOnSurface
        return r
    }()
    
//    lazy var lineView: LyricLineView = {
//        let r = LyricLineView()
//        r.tg_width.equal(.fill)
//        r.tg_height.equal(14)
//        r.gravity = .left
//        r.lyricTextSize = 12
//        
//        //这一行歌词始终是选中状态
//        r.lineSelected = true
//        return r
//    }()
    
}

//
//  PlayListCell.swift
//  播放列表cell
//
//  Created by Tao on 2025/12/26.
//

import UIKit
import TangramKit

class PlayListCell: BaseTableViewCell {
    var deleteView:QMUIButton!
    
    override func initViews() {
        super.initViews()
        container.tg_padding = UIEdgeInsets(top: 0, left: PADDING_OUTER, bottom: 0, right: PADDING_SMALL)
        container.tg_space = PADDING_MEDDLE
        container.tg_gravity = TGGravity.vert.center
        
        container.addSubview(titleView)
        
        deleteView = ViewFactoryUtil.button(image: R.image.close()!.withTintColor())
        deleteView.tintColor = .black80
        deleteView.tg_width.equal(50)
        deleteView.tg_height.equal(50)
        container.addSubview(deleteView)
    }
    
    func bind(_ data:Song) {
        titleView.text = "\(data.title!) - \(data.singer.nickname!)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            titleView.textColor = .colorPrimary
        } else {
            titleView.textColor = .colorOnSurface
        }
    }

    lazy var titleView: UILabel = {
        let r = UILabel()
        r.tg_width.equal(.fill)
        r.tg_height.equal(.wrap)
        r.numberOfLines = 2
        r.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        r.textColor = .colorOnSurface
        return r
    }()
}

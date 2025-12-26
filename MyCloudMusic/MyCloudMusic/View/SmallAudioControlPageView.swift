//
//  SmallAudioControlPageView.swift
//  小的音频播放控制view
//  就是在主界面底部显示的那个小控制条，可以左右滚动切换音乐
//  Created by Tao on 2025/12/26.
//

import UIKit
import TangramKit

class SmallAudioControlPageView: TGLinearLayout {
    
    init() {
        super.init(frame:.zero, orientation: .horz)
        innerInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        innerInit()
    }
    
    func innerInit() {
        let r = UILabel()
        r.tg_width.equal(.wrap)
        r.tg_height.equal(.wrap)
        r.text = "Tao"
        addSubview(r)
    }
    
}

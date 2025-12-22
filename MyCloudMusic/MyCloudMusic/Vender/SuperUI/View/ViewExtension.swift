//
//  ViewExtension.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/22.
//

import Foundation

import TangramKit

extension UIView{
    
    /// 隐藏
    func hide() {
        tg_visibility = .gone
    }
    
    /// 显示
    /// - Parameter data: <#data description#>
    func show(_ data:Bool=true) {
        tg_visibility = data ? .visible : .gone
    }
    
    /// 显示
    /// - Parameter data: <#data description#>
    func visible(_ data:Bool=true) {
        tg_visibility = data ? .visible : .invisible
    }
    
    /**
     * 隐藏控件，暂用位置
     */
    func invisible() {
        tg_visibility = TGVisibility.invisible
    }
    
    /**
     * 是否显示了
     */
    func isShow() -> Bool {
        return tg_visibility == TGVisibility.visible
    }
    
    /**
     * 显示或隐藏
     */
    func toggle() {
        if (isShow()) {
            hide()
        } else {
            show()
        }
    }
    
    /// 更改View锚点
    /// 会自动修正位置的偏移
    ///
    /// - Parameter anchorPoint:
    func setViewAnchorPoint(_ anchorPoint:CGPoint) {
        //原来的锚点
        let originAnchorPoint = layer.anchorPoint
        
        //要偏移的锚点
        let offetPoint = CGPoint(x: anchorPoint.x - originAnchorPoint.x, y: anchorPoint.y - originAnchorPoint.y)
        
        //要偏移的距离
        let offetX=(offetPoint.x) * frame.size.width
        let offetY=(offetPoint.y) * frame.size.height
        
        //设置这个值 说明已经改变了偏移量
        layer.anchorPoint = anchorPoint
        
        //将指定的偏宜量更改回来
        layer.position = CGPoint(x: layer.position.x + offetX, y: layer.position.y + offetY)
    }
}


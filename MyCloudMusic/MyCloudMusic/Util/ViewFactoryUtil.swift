//
//  ViewFactoryUtil.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/15.
//
import UIKit
import TangramKit

class ViewFactoryUtil {
    
    /// 主色调,小圆角按钮
    /// - Returns: <#description#>
    static func primaryButton() -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = false
        r.adjustsButtonWhenHighlighted = true
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        r.tg_width.equal(.fill)
        r.tg_height.equal(BUTTON_MEDDLE)
        r.backgroundColor = .colorPrimary
        r.layer.cornerRadius = SMALL_RADIUS
        r.tintColor = .colorLightWhite
        r.setTitleColor(.colorLightWhite, for: .normal)
        return r
    }
    
    /// 主色调,半圆角按钮
    /// - Returns: <#description#>
    static func primaryHalfFilletButton() -> QMUIButton {
        let r = primaryButton()
        r.layer.cornerRadius = BUTTON_MEDDLE_RADIUS
        return r
    }
    
    
    /// 主色调文本,小圆角按钮,灰色边框
    /// - Returns: <#description#>
    static func primaryOutlineButton() -> QMUIButton {
        let r = primaryButton()
        r.layer.cornerRadius = SMALL_RADIUS
        
        r.tintColor = .black130
        r.layer.borderWidth = 1
        r.layer.borderColor = UIColor.black130.cgColor
        r.backgroundColor = .clear
        r.setTitleColor(.colorPrimary, for: .normal)
        return r
    }
    
    static func primaryHalfFilletOutlineButton() -> QMUIButton {
        let result = primaryOutlineButton()
        result.layer.cornerRadius = BUTTON_MEDDLE_RADIUS
        return result
    }
    
    /// 创建只有标题按钮（类似网页连接）
    static func linkButton() -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = false
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        return r
    }
    
    
    
}

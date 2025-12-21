//
//  ViewCornerExtension.swift
//  扩展view圆角相关方法
//
//  Created by Tao on 2025/12/21.
//

import UIKit

extension UIView{
    /// 设置大圆角
    ///
    /// - Parameter view: 要设置的View
    func largeCorner() {
        corner(SuperConfig.SIZE_LARGE_RADIUS)
    }
    
    /// 显示小的圆角
    /// 这样实现会产生离屏渲染，也就是有性能影响，后面在优化
    ///
    /// - Parameter view: <#view description#>
    func smallCorner() {
        corner(SuperConfig.SIZE_SMALL_RADIUS)
    }
    
    /// 设置圆角
    ///
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - radius: <#radius description#>
    func corner(_ radius:CGFloat = MEDDLE_RADIUS) {
        //裁剪多余的内容
        //例如：给ImageView设置了圆角
        //如果不裁剪多余的内容，就不会生效
        self.clipsToBounds=true
        
        self.layer.cornerRadius=CGFloat(radius)
        
    }
    
    /// 显示边框
    ///
    /// - Parameter color: <#color description#>
    func border(_ color:UIColor) {
        //边框为1
        self.layer.borderWidth=1
        
        //边框颜色
        self.layer.borderColor=color.cgColor
    }
}


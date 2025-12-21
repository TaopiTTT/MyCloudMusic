//
//  SuperImageExtension.swift
//  Image扩展，例如:写入文件
//
//  Created by Tao on 2025/12/21.
//

import UIKit

extension UIImage{
    
    /// 设置图片支持着色
    /// - Parameter data: <#data description#>
    /// - Returns: <#description#>
    func withTintColor() -> UIImage {
        let result = self.withRenderingMode(.alwaysTemplate)
        return result
    }
}

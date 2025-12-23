//
//  ImageViewWebImageExtension.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/23.
//

import UIKit

extension UIImageView{
    /// 显示头像
    /// - Parameter data: <#data description#>
    func showAvatar2(_ data:String?) {
        show(data, "DefaultAvatar")
    }
    
    /// 显示网络图片
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - data: <#data description#>
    ///   - defaultRes: defaultRes description
    func show2(_ data: String?, _ defaultImage: String = "Placeholder") {
        if (SuperStringUtil.isBlank(data)) {
            //空

            //显示默认图片
            self.image = UIImage(named: defaultImage)
        } else {
            var newData:String!
            if data!.starts(with: "http") {
                newData = data
            }else{
                newData = data!.absoluteUri()
            }
            
            showFull2(newData)
        }
    }
    
    func showFull2(_ data:String) {
        sd_setImage(with: URL(string: data))
    }
    
}

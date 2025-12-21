//
//  ImageViewKingfisherExtension.swift
//  Kingfisher显示图片扩展
//
//  Created by Tao on 2025/12/21.
//

import UIKit

//图片加载
import Kingfisher

extension UIImageView{
    /// 显示头像
    /// - Parameter data: <#data description#>
    func showAvatar(_ data:String?) {
        show(data, "DefaultAvatar")
    }
    
    /// 显示网络图片
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - data: <#data description#>
    ///   - defaultRes: <#defaultRes description#>
    func show(_ data:String?,_ defaultImage:String="Placeholder") {
        if SuperStringUtil.isBlank(data) {
            //空

            //显示默认图片
            image = UIImage(named: defaultImage)
        } else {
            var newData:String!
            if data!.starts(with: "http") {
                newData = data
            } else {
                newData = data?.absoluteUri()
            }
            
            showFull(newData)
        }
    }
    
    /// 显示绝对路径
    /// - Parameter data: <#data description#>
    func showFull(_ data:String) {
        kf.indicatorType = .activity
        kf.setImage(with: URL(string: data))
    }
    
    /// 显示本地图片
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - data: <#data description#>
    ///   - defaultRes: <#defaultRes description#>
    func showLocal(_ data: String?, _ defaultImage: String = "Placeholder") {
        if (SuperStringUtil.isBlank(data)) {
            //空

            //显示默认图片
            self.image = UIImage(named: defaultImage)
        } else {
            kf.indicatorType = .activity
            
            let url = URL(fileURLWithPath: data!)
            let provider = LocalFileImageDataProvider(fileURL: url)
            
            kf.setImage(with: provider)
        }
    }
}


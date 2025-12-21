//
//  StringExtension.swift
//  字符串扩展
//
//  Created by Tao on 2025/12/21.
//

import Foundation

extension String{
    /**
     * 将相对资源转为绝对路径
     *
     * @param uri
     * @return
     */
    func absoluteUri() -> String {
        return "\(Config.RESOURCE_ENDPOINT)\(self)"
    }
}

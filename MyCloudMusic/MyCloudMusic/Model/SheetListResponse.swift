//
//  SheetListResponse.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/17.
//

import Foundation
import HandyJSON

class SheetListResponse:HandyJSON {
    var status:Int = 0
    var data:PageResponse!
    
    required init() {}
}

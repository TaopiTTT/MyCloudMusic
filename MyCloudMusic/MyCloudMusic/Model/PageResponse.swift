//
//  PageResponse.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/17.
//

import Foundation
import HandyJSON

class PageResponse: HandyJSON {
    var total:Int = 0
    var pages:Int = 0
    var data:[Sheet]!
//    var data:Array<Sheet>!
    
    required init() {}
}

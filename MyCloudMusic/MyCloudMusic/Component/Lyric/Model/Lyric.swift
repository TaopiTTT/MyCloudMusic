//
//  Lyric.swift
//  歌词模型
//
//  Created by Tao on 2025/12/24.
//

import UIKit

class Lyric: BaseModel {
    /// 是否是精确到字的歌词
    var isAccurate:Bool = false
    
    /// 所有的歌词
    var datum:Array<LyricLine>!
}

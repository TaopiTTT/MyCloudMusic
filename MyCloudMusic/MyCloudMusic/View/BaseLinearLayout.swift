//
//  BaseLinearLayout.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/26.
//

import UIKit
import TangramKit

class BaseLinearLayout: TGLinearLayout {
    init() {
        super.init(frame: .zero,orientation: .vert)
        initViews()
        initDatum()
        initListeners()
    }
    
    init(orientation:TGOrientation) {
        super.init(frame: .zero,orientation: orientation)
        initViews()
        initDatum()
        initListeners()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
        initDatum()
        initListeners()
    }
    
    /// 找控件
    func initViews() {
        
    }

    /// 设置数据
    func initDatum() {
        
    }

    /// 设置监听器
    func initListeners()  {
        
    }
}

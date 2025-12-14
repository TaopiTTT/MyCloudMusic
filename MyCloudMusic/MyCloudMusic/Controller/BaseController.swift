//
//  BaseController.swift
//  所有控制器的父类
//
//  Created by Tao on 2025/12/14.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    func initListeners() {
        
    }
    

}

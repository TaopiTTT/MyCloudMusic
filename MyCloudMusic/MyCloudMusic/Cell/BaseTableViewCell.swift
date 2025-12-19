//
//  BaseTableViewCell.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/19.
//

import UIKit

//提供类似Android中更高层级布局框架
import TangramKit

class BaseTableViewCell: UITableViewCell {
    //对于需要动态评估高度的UITableViewCell来说可以把布局视图暴露出来。用于高度评估和边界线处理。以及事件处理的设置。
    var container:TGBaseLayout!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        innerInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        innerInit()
    }
    
    func innerInit() {
        initViews()
        initDatum()
        initListeners()
    }
    
    /// 找控件
    func initViews() {
        //背景透明
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        //去掉默认的选中颜色
        selectionStyle = .none
        
        //根容器
        container = TGLinearLayout(getContainerOrientation())
        container.tg_width.equal(.fill)
        container.tg_height.equal(.wrap)
        container.tg_space = PADDING_MEDDLE
        contentView.addSubview(container)
    }
    
    /// 设置数据
    func initDatum() {
        
    }
    
    /// 设置监听器
    func initListeners()  {
        
    }
    
    /// 获取根容器布局方向
    func getContainerOrientation() -> TGOrientation {
        return .horz
    }
    
    /// 使用TangramKit后，让item自动计算高度，要重写该方法
    /// - Parameters:
    ///   - targetSize: <#targetSize description#>
    ///   - horizontalFittingPriority: <#horizontalFittingPriority description#>
    ///   - verticalFittingPriority: <#verticalFittingPriority description#>
    /// - Returns: <#description#>
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return self.container.systemLayoutSizeFitting(targetSize)
    }
}


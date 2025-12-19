//
//  BannerCell.swift
//  轮播图Cell
//
//  Created by Tao on 2025/12/19.
//

import UIKit

class BannerCell: BaseTableViewCell {

    var bannerView:YJBannerView!
    var data:BannerData!
    var datum:[String] = []
    var bannerClick:((Ad)->Void)!
    
    override func initViews() {
        super.initViews()
        //底部的距离，由下一个控件设置，除非不方便设置
        container.tg_padding = UIEdgeInsets(top: PADDING_OUTER, left: PADDING_OUTER, bottom: 0, right: PADDING_OUTER)
        
        //轮播图
        bannerView=YJBannerView()
        bannerView.backgroundColor = .clear
        bannerView.dataSource = self
        bannerView.delegate = self
        bannerView.tg_width.equal(.fill)
        
        //SCREEN_WIDTH是QMUI提供的宏
        //直接在initViews里面这样获取self.contentView.frame.size.width是默认值
        //而不是应用了自动布局后的值
        bannerView.tg_height.equal(UIScreen.main.bounds.width * 0.389)
        
        bannerView.clipsToBounds = true
        bannerView.layer.cornerRadius = MEDDLE_RADIUS
        
        //设置如果找不到图片显示的图片
        bannerView.emptyImage=R.image.placeholder()
        
        //设置占位图
        bannerView.placeholderImage=R.image.placeholder()
        
        //设置轮播图内部显示图片的时候调用什么方法
        bannerView.bannerViewSelectorString="sd_setImageWithURL:placeholderImage:"
        
        //设置指示器默认颜色
        bannerView.pageControlNormalColor = .black80
        
        //高亮的颜色
        bannerView.pageControlHighlightColor = .colorPrimary
        
        container.addSubview(bannerView)
    }
    
    /// 绑定数据
    /// - Parameter data: <#data description#>
    func bind(_ data:BannerData) {
        self.data=data
        
        //清除原来的数据
        datum.removeAll()
        
        //循环每一个广告
        //取出广告的地址
        //放到一个数组中
        for it in data.data {
            datum.append(ResourceUtil.resourceUri(it.icon))
        }
        
        //通知轮播图框架从新加载数据
        bannerView.reloadData()
    }
}

// MARK: - banner数据源和代理
extension BannerCell:YJBannerViewDataSource,YJBannerViewDelegate{
    /// 返回BannerView要显示的数据
    ///
    /// - Parameter bannerView: <#bannerView description#>
    /// - Returns: <#return value description#>
    func bannerViewImages(_ bannerView: YJBannerView!) -> [Any]! {
        return datum
    }
    
    /// 自定义Cell
    /// 复写该方法的目的是
    /// 设置图片的缩放模式
    ///
    /// - Parameters:
    ///   - bannerView: <#bannerView description#>
    ///   - customCell: <#customCell description#>
    ///   - index: <#index description#>
    /// - Returns: <#return value description#>
    func bannerView(_ bannerView: YJBannerView!, customCell: UICollectionViewCell!, index: Int) -> UICollectionViewCell! {
        //将cell类型转为YJBannerViewCell
        let cell = customCell as! YJBannerViewCell
        
        //设置图片的缩放模式为
        //从中心填充
        //多余的裁剪掉
        cell.showImageViewContentMode = .scaleAspectFill
        
        return cell
    }
}

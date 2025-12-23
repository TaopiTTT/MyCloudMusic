//
//  ViewFactoryUtil.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/15.
//
import UIKit
import TangramKit

class ViewFactoryUtil {
    
    /// 主色调,小圆角按钮
    /// - Returns: <#description#>
    static func primaryButton() -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = false
        r.adjustsButtonWhenHighlighted = true
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_LARGE)
        r.tg_width.equal(.fill)
        r.tg_height.equal(BUTTON_MEDDLE)
        r.backgroundColor = .colorPrimary
        r.layer.cornerRadius = SMALL_RADIUS
        r.tintColor = .colorLightWhite
        r.setTitleColor(.colorLightWhite, for: .normal)
        return r
    }
    
    /// 主色调,半圆角按钮
    /// - Returns: <#description#>
    static func primaryHalfFilletButton() -> QMUIButton {
        let r = primaryButton()
        r.layer.cornerRadius = BUTTON_MEDDLE_RADIUS
        return r
    }
    
    
    /// 主色调文本,小圆角按钮,灰色边框
    /// - Returns: <#description#>
    static func primaryOutlineButton() -> QMUIButton {
        let r = primaryButton()
        r.layer.cornerRadius = SMALL_RADIUS
        
        r.tintColor = .black130
        r.layer.borderWidth = 1
        r.layer.borderColor = UIColor.black130.cgColor
        r.backgroundColor = .clear
        r.setTitleColor(.colorPrimary, for: .normal)
        return r
    }
    
    static func primaryHalfFilletOutlineButton() -> QMUIButton {
        let result = primaryOutlineButton()
        result.layer.cornerRadius = BUTTON_MEDDLE_RADIUS
        return result
    }
    
    /// 创建只有标题按钮（类似网页连接）
    static func linkButton() -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = false
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        return r
    }
    
    /// 创建次要，半圆角，小按钮
    /// - Returns: <#description#>
    static func secondHalfFilletSmallButton() -> QMUIButton {
        let r = QMUIButton()
        r.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_SMALL)
        r.tg_width.equal(90)
        r.tg_height.equal(BUTTON_SMALL)
        r.tintColor = .black80
        r.border(.black80)
        r.corner(BUTTON_SMALL_RADIUS)
        r.setTitleColor(.black80, for: .normal)
        return r
    }
    
    /// 创建图片按钮
    static func button(image:UIImage) -> QMUIButton {
        let r = QMUIButton()
        r.adjustsTitleTintColorAutomatically = true
        r.tg_width.equal(30)
        r.tg_height.equal(30)
        r.tintColor = .colorOnSurface
        r.setImage(image, for: .normal)
        return r
    }
    
    static func buttonLarge(_ data:UIImage) -> QMUIButton {
        let result = button(image:data)
        result.tg_width.equal(40)
        result.tg_height.equal(40)
        return result
    }
    
    static func button(title:String,color:UIColor) -> QMUIButton {
        let result = QMUIButton()
        result.adjustsTitleTintColorAutomatically = false
        result.tg_width.equal(.fill)
        result.tg_height.equal(BUTTON_MEDDLE)
        result.titleLabel?.font = UIFont.systemFont(ofSize: TEXT_LARGE3)
        result.setTitle(title, for: .normal)
        result.setTitleColor(color, for: .normal)
        result.backgroundColor = .colorBackground
        
        //按下高亮时的背景色
        result.highlightedBackgroundColor = .colorSurfaceClick
        return result
    }
    
    /// 创建更多 图片控件
    static func moreIconView() -> UIImageView {
        let result = UIImageView()
        result.tg_width.equal(15)
        result.tg_height.equal(15)
        result.image = R.image.superChevronRight()?.withTintColor()
        result.tintColor = .black80
        result.tg_centerY.equal(0)
        
        //图片完全显示到控件里面
        result.contentMode = .scaleAspectFit
        
        return result;
    }
    
    /// 创建TableView
    static func tableView() -> UITableView {
        let r = QMUITableView()
        r.backgroundColor = .clear
        
        //去掉没有数据cell的分割线
        r.tableFooterView = UIView()
        
        //去掉默认分割线
        r.separatorStyle = .none
        
        //修复默认分割线，向右偏移问题
        r.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(.fill)
        
        //设置所有cell的高度为高度自适应，如果cell高度是动态的请这么设置。 如果不同的cell有差异那么可以通过实现协议方法-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
        //如果您最低要支持到iOS7那么请您实现-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath方法来代替这个属性的设置。
        r.rowHeight = UITableView.automaticDimension
        
        r.estimatedRowHeight = UITableView.automaticDimension
        
        //不显示滚动条
        r.showsVerticalScrollIndicator = false
        
        r.allowsSelection = true
        
        //分割线颜色
        r.separatorColor = .colorDivider
        
        return r
    }
    
    /// 创建CollectionView
    static func collectionView() -> UICollectionView {
        let r = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout())
        
        r.backgroundColor = .clear
        
        //不显示滚动条
        r.showsHorizontalScrollIndicator = false
        r.showsVerticalScrollIndicator = false
        
        //collectionView的内容从collectionView顶部距离开始显示，不要自动偏移状态栏尺寸
        r.contentInsetAdjustmentBehavior = .never
        
        r.tg_width.equal(.fill)
        r.tg_height.equal(.fill)
        
        return r
    }
    
    static func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let r = UICollectionViewFlowLayout()
        r.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //滚动方向
        r.scrollDirection = .vertical
        
        //每个Cell的行间距
        r.minimumLineSpacing = 0
        
        //每个Cell的列间距
        r.minimumInteritemSpacing = 0
        
        return r
    }
    
    /// 创建小水平分割线
    static func smallDivider() -> UIView {
        let r = UIView()
        r.tg_width.equal(.fill)
        r.tg_height.equal(PADDING_MIN)
        r.backgroundColor = .colorDivider
        return r
    }
    
    static func orientationContainer(_ orientation:TGOrientation = .horz) -> TGLinearLayout {
        let result = TGLinearLayout(orientation)
        result.tg_width.equal(.fill)
        result.tg_height.equal(.wrap)
        
        return result
    }
}

//
//  SheetGroupCell.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/21.
//

import UIKit

import TangramKit

/// 协议
protocol SheetGroupDelegate:NSObjectProtocol {
    /// 歌单点击回调
    /// - Parameter data: 点击的歌单对象
    func sheetClick(data:Sheet)
}

class SheetGroupCell: BaseTableViewCell {
    static let NAME = "SheetGroupCell"
    var datum:Array<Sheet> = []
    var cellWidth:CGFloat!
    var cellHeight:CGFloat!
    var spanCount:CGFloat = 3
    weak open var delegate: SheetGroupDelegate?
    
    override func initViews() {
        super.initViews()
        //分割线
        container.addSubview(ViewFactoryUtil.smallDivider())
        
        //标题
        container.addSubview(titleView)
        
        container.addSubview(collectionView)
        
        collectionView.register(SheetCell.self, forCellWithReuseIdentifier: Constant.CELL)
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    func bind(_ data:SheetData) {
        //计算每个cell宽度
        
        //屏幕宽度-外边距16*2-(self.spanCount-1)*5
        cellWidth = (SCREEN_WIDTH-PADDING_OUTER*CGFloat(2) - (spanCount - CGFloat(1))*PADDING_SMALL)/spanCount
        
        //cell高度，5:图片和标题边距，40：2行文字高度
        cellHeight = cellWidth + PADDING_SMALL + 40
        
        //计算可以显示几行
        let rows = ceil(CGFloat(data.datum.count) / spanCount)
        
        //CollectionView高度等于，行数*行高，10：垂直方向每个cell间距
        let viewHeight = rows * (cellHeight + PADDING_MEDDLE)
        
        collectionView.tg_height.equal(viewHeight)
        
        datum.removeAll()
        
        datum += data.datum
        collectionView.reloadData()
    }
    
    /// 标题控件
    lazy var titleView: ItemTitleView = {
        let r = ItemTitleView()
        r.titleView.text = R.string.localizable.recommendSheet()
        return r
    }()
    
    lazy var collectionView: UICollectionView = {
        let r = ViewFactoryUtil.collectionView()
        r.delegate = self
        r.dataSource = self
        r.isScrollEnabled = false
        
        return r
    }()
}

/// CollectionView数据源和代理
extension SheetGroupCell:UICollectionViewDataSource,UICollectionViewDelegate {
    
    /// 有多少个
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datum.count
    }
    
    /// 返回cell
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = datum[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CELL, for: indexPath) as! SheetCell
        
        cell.bind(data)
        
        return cell
    }
    
    /// item点击
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - indexPath: <#indexPath description#>
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let d = delegate {
            d.sheetClick(data:datum[indexPath.row])
        }
    }
}

/// UICollectionViewDelegateFlowLayout
extension SheetGroupCell:UICollectionViewDelegateFlowLayout{
    /// 返回CollectionView里面的Cell到CollectionView的间距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
    }
    
    /// 返回每个Cell的行间距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - section: <#section description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return PADDING_MEDDLE
    }
    
    /// 返回每个Cell的列间距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return PADDING_SMALL
    }
    
    /// cell尺寸
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}


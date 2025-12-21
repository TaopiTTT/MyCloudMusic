//
//  SongGroupCell.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/21.
//

import UIKit
import TangramKit
import SwiftEventBus

class SongGroupCell: BaseTableViewCell {
    static let NAME = "SongGroupCell"
    var data:SongData!
    
    //发现界面每个单曲cell高度，51：图片高度，10*2：上下两个边距
    static let HEIGHT_DISCOVERY_SONG:CGFloat = 51+10*2
    
    override func initViews() {
        super.initViews()
        //分割线
        container.addSubview(ViewFactoryUtil.smallDivider())
        
        //标题
        container.addSubview(titleView)
        
        container.addSubview(self.tableView)
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    func bind(_ data:SongData) {
        self.data = data
        //高度等于，行数*行高
        let viewHeight = CGFloat(data.datum.count) * SongGroupCell.HEIGHT_DISCOVERY_SONG
        tableView.tg_height.equal(viewHeight)
        
        tableView.reloadData()
    }
    
    /// 标题控件
    lazy var titleView: ItemTitleView = {
        let r = ItemTitleView()
        r.titleView.text = R.string.localizable.recommendSong()
        return r
    }()
    
    lazy var tableView: UITableView = {
        let result=ViewFactoryUtil.tableView()
        result.separatorStyle = .singleLine
        
        //分割线颜色
        result.separatorColor = .colorDivider
        result.delegate = self
        result.dataSource = self
        
        //注册cell
        result.register(DiscoverySongCell.self, forCellReuseIdentifier: Constant.CELL)
        
        return result
    }()
}

/// 数据源和代理
extension SongGroupCell:QMUITableViewDelegate,QMUITableViewDataSource{
    /// 有多少个
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.datum.count
    }
    
    /// 返回cell
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = data.datum[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CELL, for: indexPath) as! DiscoverySongCell
        
        if indexPath.row == 0 {
            cell.container.tg_padding = UIEdgeInsets(top: 0, left: PADDING_OUTER, bottom: PADDING_MEDDLE, right: PADDING_OUTER)
        } else {
            cell.container.tg_padding = UIEdgeInsets(top: PADDING_MEDDLE, left: PADDING_OUTER, bottom: PADDING_MEDDLE, right: PADDING_OUTER)
        }
        
        cell.bind(data)
        
        return cell
    }
    
    /// 点击了cell
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SwiftEventBus.post(Constant.EVENT_SONG_CLICK, sender: data.datum[indexPath.row])
    }
}

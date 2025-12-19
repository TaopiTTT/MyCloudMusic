//
//  DiscoveryController.swift
//  发现界面
//
//  Created by Tao on 2025/12/19.
//

import UIKit

class DiscoveryController: BaseLogicController {

    
    override func initViews() {
        super.initViews()
        
        //初始化TableView结构
        initTableViewSafeArea()
        
        //注册轮播图cell
        tableView.register(BannerCell.self, forCellReuseIdentifier: Constant.CELL)
        tableView.register(DiscoveryButtonCell.self, forCellReuseIdentifier: DiscoveryButtonCell.NAME)
        
    }
    
    override func initDatum() {
        super.initDatum()
        
        loadData()
    }
    
    func loadData() {
        DefaultRepository.shared
            .bannerAds()
            .subscribeSuccess {[weak self] data in
                //清除原来的数据
                self?.datum.removeAll()
                
                //添加轮播图
                self?.datum.append(BannerData(data.data!.data!))
                
                //添加快捷按钮
                self?.datum.append(ButtonData())
                
//                //请求歌单数据
//                self?.loadSheetData()
                self?.tableView.reloadData()
            }.disposed(by: rx.disposeBag)
    }
    
    /// 广告点击
    /// - Parameter data: <#data description#>
    func processAdClick(_ data:Ad) {
        print("ClickResult: \(data.title)")
    }
    
    /// 获取列表类型
    ///
    /// - Parameter data: <#data description#>
    /// - Returns: <#return value description#>
    func typeForItemAtData(_ data:Any) -> MyStyle {
        if data is ButtonData {
            //按钮
            return .button
        }
//        else if data is SheetData{
//            return .sheet
//        }else if data is SongData{
//            return .song
//        }else if data is FooterData{
//            return .footer
//        }
        
        return .banner
    }

}

// MARK: - 列表数据源和代理
extension DiscoveryController{
    
    /// 返回当前位置cell
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datum[indexPath.row]
        //获取当前Cell的类型
        let type = typeForItemAtData(data)
        
        switch type {
        case .button:
            //按钮
            
            //取出一个Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoveryButtonCell.NAME, for: indexPath) as! DiscoveryButtonCell
            
            cell.bind(data as! ButtonData)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CELL, for: indexPath) as! BannerCell
            
            cell.bind(data as! BannerData)
            
            cell.bannerClick = {[weak self] data in
                self?.processAdClick(data)
            }
            
            return cell
        }
        

    }
    
}
    

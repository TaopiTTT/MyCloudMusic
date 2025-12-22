//
//  DiscoveryController.swift
//  发现界面
//
//  Created by Tao on 2025/12/19.
//

import UIKit
import SwiftEventBus

class DiscoveryController: BaseMainController {

    
    override func initViews() {
        super.initViews()
        
        //初始化TableView结构
        initTableViewSafeArea()
        
        //下拉刷新
        let header=MJRefreshNormalHeader {
            [weak self] in
            self?.loadData()
        }

        //隐藏标题
        header.stateLabel?.isHidden = true

        // 隐藏时间
        header.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header=header
        
        //注册轮播图cell
        tableView.register(BannerCell.self, forCellReuseIdentifier: Constant.CELL)
        tableView.register(DiscoveryButtonCell.self, forCellReuseIdentifier: DiscoveryButtonCell.NAME)
        tableView.register(SheetGroupCell.self, forCellReuseIdentifier: SheetGroupCell.NAME)
        tableView.register(SongGroupCell.self, forCellReuseIdentifier: SongGroupCell.NAME)
        tableView.register(DiscoveryFooterCell.self, forCellReuseIdentifier: DiscoveryFooterCell.NAME)
        
    }
    
    func startRefresh() {
        //进入界面后自动刷新，会调用回调方法
        tableView.mj_header!.beginRefreshing()
    }
    
    func endRefresh()  {
        tableView.mj_header!.endRefreshing()
    }
    
    override func initDatum() {
        super.initDatum()
        startRefresh()
//        loadData()
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
                
                //请求歌单数据
                self?.loadSheetData()
                
            }.disposed(by: rx.disposeBag)
    }
    
    /// 请求歌单数据
    func loadSheetData() {
        DefaultRepository.shared
            .sheets(size: VALUE12)
            .subscribeSuccess {[weak self] data in
                //添加歌单数据
                self?.datum.append(SheetData(data.data!.data!))
                
                //请求单曲数据
                self?.loadSongData()
                
            }.disposed(by: rx.disposeBag)
    }
    
    func loadSongData() {
        DefaultRepository.shared.songs()
            .subscribeSuccess {[weak self] data in
                self?.endRefresh()
                
                //添加单曲数据
                self?.datum.append(SongData(data.data!.data!))
                
                //添加尾部数据
                self?.datum.append(FooterData())
                
                
                //请求启动界面广告，当然也可以和轮播图接口一起返回
//                self?.loadSplashAd()
                self?.tableView.reloadData()
            }.disposed(by: rx.disposeBag)
    }
    
    /// 广告点击
    /// - Parameter data: <#data description#>
    func processAdClick(_ data:Ad) {
//        print("ClickResult: \(data.title)")
        if data.uri.starts(with: "http") {
            SuperWebController.start(navigationController!,title: data.title,uri: data.uri)
        }
    }
    
    override func initListeners() {
        super.initListeners()
        //监听单曲点击事件
        SwiftEventBus.onMainThread(self, name: Constant.EVENT_SONG_CLICK) {[weak self] data in
            self?.processSongClick(data?.object as! Song)
        }
        
        //点击事件，根据style区分具体是什么点击
        SwiftEventBus.onMainThread(self, name: Constant.CLICK_EVENT) { [weak self] sender in

            //获取发送过来的数据
            let data = sender?.object as! MyStyle

            self?.processClick(data)
        }
        
    }
    
    func processClick(_ data:MyStyle) {
        switch data {
        case .refresh:
            //底部刷新
            autoRefresh()
        default:
            break
        }
    }
    
    func autoRefresh() {
        //滚动到顶部
        let indexPath = IndexPath(item: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
        //延时300毫秒，执行加载数据，目的是让列表先向上滚动到顶部
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {[weak self] in
            self?.startRefresh()
        }
    }
    
    /// 单曲点击
    /// - Parameter data: <#data description#>
    func processSongClick(_ data:Song) {
        print("DiscoveryController processSongClick \(data.title)")
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
        else if data is SheetData{
            return .sheet
        }
        else if data is SongData{
            return .song
        }
        else if data is FooterData{
            return .footer
        }
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
        case .sheet:
            //歌单
            let cell = tableView.dequeueReusableCell(withIdentifier: SheetGroupCell.NAME, for: indexPath) as! SheetGroupCell
            
            cell.bind(data as! SheetData)
            cell.delegate = self
            return cell
        case .song:
            //单曲
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SongGroupCell.NAME, for: indexPath) as! SongGroupCell
            
            cell.bind(data as! SongData)
            
            return cell
        case .footer:
            //底部
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoveryFooterCell.NAME, for: indexPath)
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
    
// 实现歌单组协议
extension DiscoveryController:SheetGroupDelegate{
    func sheetClick(data: Sheet) {
        print("SheetDetailController sheetClick \(data.title)")
    }
}

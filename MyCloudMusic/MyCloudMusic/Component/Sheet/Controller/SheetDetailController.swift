//
//  SheetDetailController.swift
//  歌单详情界面
//
//  Created by Tao on 2025/12/23.
//

import UIKit

class SheetDetailController: BaseMusicPlayerController {
    /// 数据id
    var id:String!
    var data:Sheet!
    
    //背景
    var backgroundImageView: UIImageView!
    
    //背景模糊
    var backgroundVisual: UIVisualEffectView!
    
    override func initViews() {
        super.initViews()
        
        //添加背景图片控件
        backgroundImageView = UIImageView()
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        //背景模糊效果
        let blur = UIBlurEffect(style: .dark)
        backgroundVisual = UIVisualEffectView(effect: blur)
        backgroundImageView.addSubview(backgroundVisual)
        
        //初始化TableView结构
        initTableViewSafeArea()
        
        //设置状态栏为亮色(文字是白色)
        setStatusBarLight()
        
        setToolbarLight()
        
        title = R.string.localizable.sheet()
        
        //注册单曲
        tableView.register(SongCell.self, forCellReuseIdentifier: Constant.CELL)
        tableView.register(SheetInfoCell.self, forCellReuseIdentifier: SheetInfoCell.NAME)
        
        //注册section
        tableView.register(SongGroupHeaderView.self, forHeaderFooterViewReuseIdentifier: SongGroupHeaderView.NAME)
        tableView.bounces = false
    }
    
    override func initDatum() {
        super.initDatum()
        loadData()
    }
    
    func loadData() {
        DefaultRepository.shared
            .sheetDetail(id)
            .subscribeSuccess {[weak self] data in
                self?.show(data.data!)
            }.disposed(by: rx.disposeBag)
    }
    
    func show(_ data:Sheet) {
        self.data=data
        
//        datum += data.songs ?? []
        backgroundImageView.show(data.icon)
        
        //使用动画显示背景图片
        UIView.animate(withDuration: 0.3) {
            //透明度设置为1
            self.backgroundImageView.alpha = 1
        }
        
        //第一组
        var groupData=SongGroupData()
        groupData.datum = [data]
        datum.append(groupData)
        
        //第二组
        if let r = data.songs {
            if !r.isEmpty {
                //有音乐才设置

                //设置数据
                groupData=SongGroupData()
                groupData.datum = r
                datum.append(groupData)
                superFooterContainer.backgroundColor = .colorLightWhite
            }
        }
    
        tableView.reloadData()
    }
    
    /// 获取列表类型
    ///
    /// - Parameter data: <#data description#>
    /// - Returns: <#return value description#>
    func typeForItemAtData(_ data:Any) -> MyStyle {
        if data is Sheet {
            return .sheet
        }
        
        return .song
    }
    
    /// 播放音乐
    /// - Parameter data: <#data description#>
    func play(_ data:Song) {
//        //把当前歌单所有音乐设置到播放列表
//        //有些应用
//        //可能会实现添加到已经播放列表功能
//        MusicListManager.shared().setDatum(self.data.songs!)
//        
//        //播放当前音乐
//        MusicListManager.shared().play(data)
//        
//        startMusicPlayerController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImageView.frame = view.bounds
        backgroundVisual.frame = backgroundImageView.bounds
    }
    
    @objc func commentClick() {
//        CommentController.start(navigationController!)
    }
}

extension SheetDetailController{
    /// 有多少组
    /// - Parameter tableView: <#tableView description#>
    /// - Returns: <#description#>
    func numberOfSections(in tableView: UITableView) -> Int {
        return datum.count
    }
    
    /// 当前组有多少个
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = datum[section] as! SongGroupData
        return data.datum.count
    }
    
    /// 返回section view
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //取出组数据
        let groupData=datum[section] as! SongGroupData
        
        //获取header
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SongGroupHeaderView.NAME) as! SongGroupHeaderView
        
        header.bind(groupData)
        
        header.playAllClick = {[weak self] in
            let groupData = self?.datum[1] as! SongGroupData
            self?.play(groupData.datum[0] as! Song)
        }
        
        return header
    }
    
    /// 返回当前位置的cell
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupData = datum[indexPath.section] as! SongGroupData
        let data = groupData.datum[indexPath.row]

        let type = typeForItemAtData(data)
        
        switch type {
        case .sheet:
            let cell = tableView.dequeueReusableCell(withIdentifier: SheetInfoCell.NAME, for: indexPath) as! SheetInfoCell
            cell.bind(data as! Sheet)
            
//            cell.commentCountView.addTarget(self, action: #selector(commentClick), for: .touchUpInside)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CELL, for: indexPath) as! SongCell
            cell.bind(data as! Song)
            cell.indexView.text = "\(indexPath.row + 1)"
            
            return cell
        }
        
        
        
    }
    
    /// header高度
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        
        //其他组不显示section
        return 0
    }
    
    /// cell点击
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupData = datum[indexPath.section] as! SongGroupData
        let data = groupData.datum[indexPath.row]
        
        let type = typeForItemAtData(data)
        
        if type == .song {
//            play(data as! Song)
        }
    }
}

extension SheetDetailController{
    /// 启动方法
    /// - Parameters:
    ///   - controller: <#controller description#>
    ///   - id: <#id description#>
    static func start(_ controller:UINavigationController,_ id:String) {
        let target = SheetDetailController()
        target.id=id
        controller.pushViewController(target, animated: true)
    }
}

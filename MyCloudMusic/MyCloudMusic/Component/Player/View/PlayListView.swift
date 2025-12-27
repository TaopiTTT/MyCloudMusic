//
//  PlayListView.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/26.
//

import UIKit
import TangramKit

class PlayListView: BaseLinearLayout {
    var countView:UILabel!
    
    override func initViews() {
        super.initViews()
        backgroundColor = .colorSurface
        
        //容器
        let orientationContainer = TGRelativeLayout()
        orientationContainer.tg_width.equal(.fill)
        orientationContainer.tg_height.equal(.wrap)
        orientationContainer.tg_padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: PADDING_SMALL)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(playAllClick))
        orientationContainer.addGestureRecognizer(tapGestureRecognizer)
        addSubview(orientationContainer)
        
        //左侧容器
        let leftContainer = TGRelativeLayout()
        leftContainer.tg_width.equal(50)
        leftContainer.tg_height.equal(50)
        orientationContainer.addSubview(leftContainer)
        
        //图标
        let iconView = UIImageView()
        iconView.tg_width.equal(30)
        iconView.tg_height.equal(30)
        iconView.tg_centerX.equal(0)
        iconView.tg_centerY.equal(0)
        iconView.image = R.image.playCircle()!.withTintColor()
        iconView.tintColor = .colorPrimary
        leftContainer.addSubview(iconView)
        
        //播放全部提示文本
        let titleView = UILabel()
        titleView.tg_width.equal(.wrap)
        titleView.tg_height.equal(.wrap)
        titleView.text = R.string.localizable.playAll()
        titleView.font = UIFont.boldSystemFont(ofSize: TEXT_LARGE2)
        titleView.textColor = .colorOnSurface
        titleView.tg_centerY.equal(0)
        titleView.tg_left.equal(leftContainer.tg_right)
        orientationContainer.addSubview(titleView)
        
        //数量
        countView = UILabel()
        countView.tg_width.equal(.wrap)
        countView.tg_height.equal(.wrap)
        countView.text = "0"
        countView.font = UIFont.systemFont(ofSize: TEXT_MEDDLE)
        countView.textColor = .black80
        countView.tg_centerY.equal(0)
        countView.tg_left.equal(titleView.tg_right).offset(PADDING_SMALL)
        orientationContainer.addSubview(countView)
        
        //删除所有按钮
        let deleteButton = ViewFactoryUtil.button(image:R.image.close()!.withTintColor())
        deleteButton.tintColor = .colorOnSurface
        deleteButton.tg_width.equal(50)
        deleteButton.tg_height.equal(50)
        deleteButton.tg_centerY.equal(0)
        deleteButton.tg_right.equal(0)
        deleteButton.addTarget(self, action: #selector(deleteAllClick), for: .touchUpInside)
        orientationContainer.addSubview(deleteButton)
        
        addSubview(ViewFactoryUtil.smallDivider())
        
        addSubview(tableView)
    }
    
    override func initDatum() {
        super.initDatum()
        countView.text = "(\(MusicListManager.shared().datum.count))"
        
        //选中当前音乐
        scrollPosition()
    }
    
    @objc func playAllClick() {
        play(0)
    }
    
    @objc func deleteAllClick() {
        MusicListManager.shared().deleteAll()
        GKCover.hide()
    }
    
    @objc func deleteClick(_ sender:QMUIButton) {
        MusicListManager.shared().delete(sender.tag)
        GKCover.hide()
    }
    
    func play(_ data:Int) {
        let r = MusicListManager.shared().datum[data]
        MusicListManager.shared().play(r)
    }
    
    /// 选中当前播放的音乐
    func scrollPosition()  {
        //获取当前音乐在播放列表中的索引
        let data = MusicListManager.shared().data!
        
        let datumOC = MusicListManager.shared().datum as NSArray
        let index = datumOC.index(of: data)
        
        if index != -1 {
            //创建indexPath
            let indexPath = IndexPath(row: index, section: 0)
            
            //延迟后选中当前音乐
            //因为前面执行可能是删除Cell操作
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let r = ViewFactoryUtil.tableView()
        r.delegate = self
        r.dataSource = self
        r.separatorStyle = .singleLine
        r.register(PlayListCell.self, forCellReuseIdentifier: Constant.CELL)
        return r
    }()
}

// MARK: -  列表数据源和代理
extension PlayListView:QMUITableViewDelegate,QMUITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicListManager.shared().datum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = MusicListManager.shared().datum[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CELL, for: indexPath) as! PlayListCell
        cell.bind(data)
        
        cell.deleteView.tag = indexPath.row
        cell.deleteView.addTarget(self, action: #selector(deleteClick(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        play(indexPath.row)
    }
}

//
//  SmallAudioControlPageView.swift
//  小的音频播放控制view
//  就是在主界面底部显示的那个小控制条，可以左右滚动切换音乐
//  Created by Tao on 2025/12/26.
//

import UIKit
import TangramKit

class SmallAudioControlPageView: TGLinearLayout {
    /// 黑胶唱片左右滚动view
    var collectionView:UICollectionView!
    
    /// 播放按钮
    var playButtonView:QMUIButton!
    
    /// 播放列表按钮
    var listButton:QMUIButton!
    
    var duration:Float = 0
    
    /// 是否在拖拽状态
    private var isDrag:Bool = false
    
    init() {
        super.init(frame:.zero, orientation: .vert)
        innerInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        innerInit()
    }
    
    func innerInit() {
//        let r = UILabel()
//        r.tg_width.equal(.wrap)
//        r.tg_height.equal(.wrap)
//        r.text = "Tao"
//        addSubview(r)
        
        //分割线
        addSubview(ViewFactoryUtil.smallDivider())
        
        //水平容器
        let orientationContainer = ViewFactoryUtil.orientationContainer()
        orientationContainer.tg_gravity = TGGravity.vert.center
        addSubview(orientationContainer)
        
        //左右滚动控件
        collectionView = ViewFactoryUtil.pageCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        orientationContainer.addSubview(collectionView)
        
        //注册cell
        collectionView.register(SongSmallCell.self, forCellWithReuseIdentifier: Constant.CELL)
        
        //播放按钮
        playButtonView = ViewFactoryUtil.button(image:R.image.playCircleBlack()!.withTintColor())
        playButtonView.tintColor = .colorOnSurface
        playButtonView.tg_width.equal(50)
        playButtonView.tg_height.equal(50)
        playButtonView.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        orientationContainer.addSubview(playButtonView)
        
        //播放列表按钮
        listButton = ViewFactoryUtil.button(image:R.image.list()!.withTintColor())
        listButton.tintColor = .colorOnSurface
        listButton.tg_width.equal(50)
        listButton.tg_height.equal(50)
        listButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        orientationContainer.addSubview(listButton)
        
    }
    
    func scrollPosition(_ data:IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            self.collectionView.scrollToItem(at: data, at: .centeredHorizontally, animated: false)
        }
    }
    
    func setPlaying(_ data:Bool) {
        let r = data ? R.image.pause()!.withTintColor() : R.image.playCircleBlack()!.withTintColor()
        playButtonView.setImage(r, for: .normal)
    }
    
    func setProgress(_ progress:Float) {
        
    }
    
    
}

// MARK: -CollectionView数据源
extension SmallAudioControlPageView:UICollectionViewDataSource,UICollectionViewDelegate{
    /// 有多少个
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MusicListManager.shared().datum.count
    }
    
    /// 返回cell
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = MusicListManager.shared().datum[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CELL, for: indexPath) as! SongSmallCell
        cell.bind(data)
        
        return cell
    }
}

// MARK: - CollectionView布局代理
extension SmallAudioControlPageView:UICollectionViewDelegateFlowLayout{
    /// 返回CollectionView里面的Cell到CollectionView的间距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    /// 返回每个Cell的行间距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// 返回每个Cell的列间距
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// item尺寸
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}


//
//  ButtonData.swift
//  MyCloudMusic
//
//  Created by Tao on 2025/12/19.
//

import Foundation

class ButtonData {
    var title:String!
    var icon:UIImage!
    var style:MyStyle = .none
    
    init(_ title:String!,_ icon:UIImage!) {
        self.title=title
        self.icon = icon
    }
    
    init(icon:UIImage,title:String,style:MyStyle = .none) {
        self.title=title
        self.icon = icon
        self.style = style
    }
    
    init() {
        
    }
    
    lazy var datum: [ButtonData] = {
        var r:[ButtonData] = []
        r.append(ButtonData(R.string.localizable.dayRecommend(),R.image.dayRecommend()))
        r.append(ButtonData(R.string.localizable.personFm(),R.image.personFm()))
        r.append(ButtonData(R.string.localizable.sheet(),R.image.sheet()))
        r.append(ButtonData(R.string.localizable.rank(),R.image.rank()))
        r.append(ButtonData(R.string.localizable.live(),R.image.buttonLive()))
        r.append(ButtonData(R.string.localizable.digitalAlbum(),R.image.digitalAlbum()))
        r.append(ButtonData(R.string.localizable.digitalAlbum(),R.image.digitalAlbum()))
        return r
    }()
}

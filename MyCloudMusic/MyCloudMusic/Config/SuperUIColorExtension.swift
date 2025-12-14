//
//  SuperUIColorExtension.swift
//  颜色配置
// 定义颜色，主要是定义项目中的颜色，然后大部分情况用定义号的动态颜色，或者项目中直接引用
// 颜色不太好取名，例如：灰色，到底多少才是灰色，每个人，每个项目可能定义不一样
// 所以这里就不在按颜色名称取名，而是把要用到的颜色，按照黑色到白色（如果是其他颜色，例如：警告位置颜色，那可以定义为警告名称）定义出来
//
//  Created by Tao on 2025/12/14.
//

import UIKit

import DynamicColor

//iOS中也提供了命名颜色，例如：.systemBackground，但无法更改他的颜色，Android中就可以根据浅色，深色修改命名的颜色，更方便
extension UIColor{
    /// 主色调
    static var primaryColor: UIColor { return DynamicColor(hex: 0xd6271c)}
    
    /// 暗一点 主色调
    static var primary30 : UIColor {return DynamicColor(hex: 0xa92e29)}

//    #pragma mark - 黑色到白色
    //颜色命名也是很大的问题，关于颜色命名方式讨论：https://www.zhihu.com/question/301985702
    //以下命名后面的数字，没有实际意思
    //后面两位是透明度
    static var blackTransparent88 : UIColor {return DynamicColor(hex: 0x00000088,useAlpha: true)}
    static var buttonTransparent88 : UIColor {return DynamicColor(hex: 0x00000088,useAlpha: true)}
    static var transparent88 : UIColor {return DynamicColor(hex: 0x88888888,useAlpha: true)}
    static var black11 : UIColor {return DynamicColor(hex: 0xbbbbbb)}
    static var black15 : UIColor {return DynamicColor(hex: 0x111111)}
    static var black17 : UIColor {return DynamicColor(hex: 0x151515)}
    static var black20 : UIColor {return DynamicColor(hex: 0x161616)}
    static var black25 : UIColor {return DynamicColor(hex: 0x191919)}
    static var black30 : UIColor {return DynamicColor(hex: 0x111111)}
    static var black31 : UIColor {return DynamicColor(hex: 0x1b1b1b)}
    static var black311 : UIColor {return DynamicColor(hex: 0x1c1c1c)}
    static var black312 : UIColor {return DynamicColor(hex: 0x1e1e1e)}
    static var black32 : UIColor {return DynamicColor(hex: 0x202020)}
    static var black33 : UIColor {return DynamicColor(hex: 0x242424)}
    static var black322 : UIColor {return DynamicColor(hex: 0x212121)}
    static var black40 : UIColor {return DynamicColor(hex: 0x353535)}
    static var black42 : UIColor {return DynamicColor(hex: 0x353535)}
    static var black43 : UIColor {return DynamicColor(hex: 0x313131)}
    static var black45 : UIColor {return DynamicColor(hex: 0x3c3c3c)}
    static var black66 : UIColor {return DynamicColor(hex: 0x666666)}
    static var black70 : UIColor {return DynamicColor(hex: 0x707070)}
    static var black80 : UIColor {return DynamicColor(hex: 0x888888)}
    static var black90 : UIColor {return DynamicColor(hex: 0xaaaaaa)}
    static var black130 : UIColor {return DynamicColor(hex: 0xc8c8c8)}
    static var black140 : UIColor {return DynamicColor(hex: 0xcfcfcf)}
    static var black150 : UIColor {return DynamicColor(hex: 0xe5e5e5)}
    static var black160 : UIColor {return DynamicColor(hex: 0xd5d5d5)}
    static var black165 : UIColor {return DynamicColor(hex: 0xd1d1d1)}
    static var black170 : UIColor {return DynamicColor(hex: 0xe1e1e1)}
    static var black180 : UIColor {return DynamicColor(hex: 0xededed)}
    static var black183 : UIColor {return DynamicColor(hex: 0xf5f5f5)}
    static var black190 : UIColor {return DynamicColor(hex: 0xf6f6f6)}

    /// 链接颜色
    static var link : UIColor {return DynamicColor(hex: 0x2440b3)}

    /// 主色调，暗一点按钮颜色
    static var primaryButton : UIColor {return DynamicColor(hex: 0x596c94)}

    /// vip金色
    static var vipBorder : UIColor {return DynamicColor(hex: 0xc4b2ad)}

    static var divider2 : UIColor {return DynamicColor(hex: 0x484848)}

    /// 亮灰色，例如：设置item右侧图标，右侧更多文本颜色
    static var lightGray : UIColor {return DynamicColor(hex: 0x888888)}

/// 错误警告颜色，主要是做敏感操作，例如：删除联系人时，确认按钮颜色
    static var warning : UIColor {return DynamicColor(hex: 0xf85353)}

    /// 优惠券文本颜色
    static var textPrice : UIColor {return DynamicColor(hex: 0xf42102)}

    /// 绿色，表示正确颜色
    static var pass : UIColor {return DynamicColor(hex: 0x0ab855)}
}



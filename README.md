# MyCloudMusic

Tips：适配本项目的[后端服务器](https://github.com/TaopiTTT/MusicServer)

## 项目简介

本项目模仿市面上常见音乐软件，已实现开屏协议确认，用户登陆验证，轮播图广告，侧滑边栏，歌单与单曲展示以及音乐播放功能。<br>

其中音乐播放时可使用进度条调整播放进度，调整歌单播放顺序（单曲循环、列表循环、随机循环等）。支持播放列表突出显示当前播放音乐、删除播放列表。<br>

**TODO**

- 推送音乐播放详情至系统控制中心
- 完成歌词解析功能，完善播放器
- 完成个人详情界面



## 项目配置环境（提供本地环境作为参考）

- 机器为Mac Mini (M4)
- Xcode Version 16.4 (16F6)
- IOS模拟器：iPhone16 + IOS18.6
- Pod 1.16.2



## 配置流程

### 克隆项目

选择合适位置克隆本项目

```bash
git clone https://github.com/TaopiTTT/MyCloudMusic.git
```

随后请进入`MyCloudMusic`目录

## 安装依赖

（直接克隆后目录中会有Podfile，为避免出现莫名其妙的Bug，推荐删除后按照以下流程重新安装依赖）

在`MyCloudMusic`目录中，首先执行

```bash
pod init
```

在生成的Podfile中导入以下依赖：

```bash
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MyCloudMusic' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyCloudMusic
  #提供类似Android中更高层级的布局框架
  #https://github.com/youngsoft/TangramKit
  pod 'TangramKit'
  
  #将资源（图片，文件等）生成类，方便到代码中方法
  #例如：let icon = R.image.settingsIcon()
  #let font = R.font.sanFrancisco(size: 42)
  #let color = R.color.indicatorHighlight()
  #let viewController = CustomViewController(nib: R.nib.customView)
  #let string = R.string.localizable.welcomeWithName("Arthur Dent")
  #https://github.com/mac-cain13/R.swift
  pod 'R.swift'
  
  #颜色工具类
  #https://github.com/yannickl/DynamicColor
  pod "DynamicColor"
  
  #腾讯开源的UI框架，提供了很多功能，例如：圆角按钮，空心按钮，TextView支持placeholder
  #https://github.com/QMUI/QMUIDemo_iOS
  #https://qmuiteam.com/ios/get-started
  pod "QMUIKit"
  
  #图片加载
  #https://github.com/SDWebImage/SDWebImage
  pod 'SDWebImage'
  
  # 网络请求框架
  # https://github.com/Moya/Moya
  pod 'Moya/RxSwift'

  #避免每个界面定义disposeBag
  #https://github.com/RxSwiftCommunity/NSObject-Rx
  pod "NSObject+Rx"
  
  # JSON解析为对象
  # https://github.com/alibaba/HandyJSON
  pod "HandyJSON"
  
  #提示框架
  # https://github.com/jdg/MBProgressHUD
  pod 'MBProgressHUD'
  
  #Swift图片加载
  # https://github.com/onevcat/Kingfisher
  pod "Kingfisher","7.9.1"
  
  #Swift扩展，像字符串，数组等
  #https://github.com/SwifterSwift/SwifterSwift
  pod 'SwifterSwift'
  
  # 发布订阅框架
  # https://github.com/cesarferreira/SwiftEventBus
  pod "SwiftEventBus"
  
  #下拉刷新
  #https://github.com/CoderMJLee/MJRefresh
  pod 'MJRefresh'
  
  #富文本框架
  #https://github.com/a1049145827/BSText
  #OC版本：https://github.com/ibireme/YYText
  pod "BSText"
  
  #腾讯开源的偏好存储框架
  #https://github.com/Tencent/MMKV
  pod 'MMKV'
  
  #验证码输入框
  #https://github.com/feaskters/MHVerifyCodeView
  pod 'MHVerifyCodeView'
  
  #腾讯WCDB是一个高效、完整、易用的移动数据库框架，基于SQLCipher，支持iOS, macOS和Android
  #https://github.com/Tencent/wcdb
  pod 'WCDB.swift',"1.0.8.2"
  
  #面向泛前端产品研发全生命周期的效率平台，查看数据库,网络请求,内存泄漏
  #https://xingyun.xiaojukeji.com/docs/dokit/#/iosGuide
  pod 'DoraemonKit/Core', :configurations => ['Debug'] #必选
  #  pod 'DoraemonKit/WithGPS', '~> 3.0.4', :configurations => ['Debug'] #可选
  #  pod 'DoraemonKit/WithLoad', '~> 3.0.4', :configurations => ['Debug'] #可选
  #  pod 'DoraemonKit/WithLogger', '~> 3.0.4', :configurations => ['Debug'] #可选
    # pod 'DoraemonKit/WithDatabase',  :configurations => ['Debug'] #可选
  #  pod 'DoraemonKit/WithMLeaksFinder',  :configurations => ['Debug'] #可选
  #  pod 'DoraemonKit/WithWeex', '~> 3.0.4', :configurations => ['Debug'] #可选
  
  #腾讯云开源的一款播放器组件，简单几行代码即可拥有类似腾讯视频强大的播放功能，包括横竖屏切换、清晰度选择、手势和小窗等基础功能，还支持视频缓存，软硬解切换和倍速播放等特殊功能，相比系统播放器，支持格式更多，兼容性更好，功能更强大，同时还具备首屏秒开、低延迟的优点，以及视频缩略图等高级能力。
  #https://cloud.tencent.com/document/product/881/20208
  #编译报错解决方法：https://www.jianshu.com/p/103c0bf7d523
  pod 'SuperPlayer'
  

  target 'MyCloudMusicTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MyCloudMusicUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      #config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
     	config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
  end
end

```

注意：以上依赖大部分可以使用最新版（截止到2025.12）。由于代码中的语法问题，数据库依赖WCDB请使用指定的1.0.8.2版本，否则可能无法正常运行。

保存后执行：

```bash
pod install
```

随后进入`MyCloudMusic.xcworkspace`即可运行本项目。
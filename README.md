# XEmptyView（简单的loading页面及空状态页面）

一句代码支持Loading动画、空状态动画、空状态静态图片显示, XEmptyView依赖于第三方库：[SnapKit](https://github.com/swiftgif/SwiftGif.git)、[lottie-ios](https://github.com/airbnb/lottie-ios.git)、[SwiftGifOrigin](https://github.com/swiftgif/SwiftGif.git).

# 使用方法
1、pod方法导入：pod 'XEmptyView', 引入 source 'https://github.com/XGG17/XPodSpec.git'

* 使用Swift5.0版本，pod方法导入完成后会同时引入 SnapKit、lottie-ios、SwiftGifOrigin 等依赖的第三方库，请注意避免版本冲突。

2、在需要使用的地方导入XEmptyView：import XEmptyView

3、调用方法
```
/** 系统加载指示器 */
view.ep.loading { (p) in
    // p.isLarge = true
    p.showContent = "加载中..."
}
```
```
/** 加载Lottie动画 */
view.ep.lottie { (p) in
    p.imageFile = "empty-lottie"
    p.showTitle = "这里是标题"
    p.showContent = "这里是描述文本这里是描述文本这里是描述文本里是描述文本这里是描述文本这里是描述文本"
}
```
```
/** 加载Gif动画 */
view.ep.gif { (p) in
    p.imageFile = "empty-gif"
    p.imageWidth = 120
    p.showTitle = "这里是标题"
    p.showContent = "这里是描述文本这里是描述文本这里是描述文本里是描述文本这里是描述文本这里是描述文本"
    p.btnImageFile = "empty_reload"
    p.clickBlock = { () in
      print("gif点击刷新")
    }
}
```
```
/** 静态空状态页 */
view.ep.image { (p) in
    p.imageFile = "empty_no_network"
    p.showTitle = "这里是标题这里是标题"
    p.showContent = "这里是描述文本这里是描述文本这里是描述文本里是描述文本这里是描述文本这里是描述文本这里是描述文本这里是描述文本"
    p.btnTitle = "点击刷新"
    p.clickBlock = { () in
      print("静态图片点击刷新")
    }
}
```
```
/** 清除空状态页 */
view.ep.clear()
```

# XEmptyProperty类属性释义
```
    // emptyView类型
    internal var emptyType: XEmptyType = XEmptyType.none
    
    // 距离顶部的距离（>0有效），默认居中
    public var topMargin: CGFloat = 0.0
    
    // 是否显示大的系统加载指示器, `emptyType == .loading` 且 `iOS13` 之后有效
    public var isLarge: Bool = false
    
    // 需要显示的资源文件（图片、lottie、gif等文件名，默认不显示)
    public var imageFile: String?
    
    // 设置图片宽度，默认自适应高度
    public var imageWidth: CGFloat?
    
    // 显示标题，传""或nil不显示(默认不显示)
    public var showTitle: String?
    
    // 标题颜色，默认#333333
    public var showTitleColor: UIColor? = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    
    // 标题字体，默认15
    public var showTitleFont: UIFont? = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
    
    // 描述文字，传""或nil不显示(默认不显示)
    public var showContent: String?
    
    // 描述颜色，默认#ababab
    public var showContentColor: UIColor? = UIColor.init(red: 171/255.0, green: 171/255.0, blue: 171/255.0, alpha: 1)
    
    // 描述字体，默认14
    public var showContentFont: UIFont? = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
    
    // 按钮文字，传""或nil不显示(默认不显示)，优先显示图片
    public var btnTitle: String?
    
    // 按钮文字字体，btnTitle设置有效，默认14
    public var btnTitleFont: UIFont? = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
    
    // 按钮文字颜色，btnTitle设置有效，默认（182 182 182 ， #b6b6b6）
    public var btnTitleColor: UIColor? = UIColor.init(red: 182/255.0, green: 182/255.0, blue: 182/255.0, alpha: 1)
    
    // 按钮边框颜色，btnTitle设置有效，默认（182 182 182 ， #b6b6b6）
    public var btnBorderColor: UIColor? = UIColor.init(red: 182/255.0, green: 182/255.0, blue: 182/255.0, alpha: 1)
    
    // 按钮宽度，btnTitle设置有效，默认120, 如设置按钮图片时，宽度自适应图片高度
    public var btnTitleWidth: CGFloat = 120
    
    // 按钮高度，btnTitle设置有效，默认40, 如设置按钮图片时，高度自适应图片高度
    public var btnTitleHeight: CGFloat = 40
    
    // 按钮图片，传""或nil不显示(默认不显示)，优先显示图片
    public var btnImageFile: String?
    
    // 点击按钮事件回调
    public var clickBlock: ClickBlock?
```

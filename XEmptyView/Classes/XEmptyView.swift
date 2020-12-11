//
//  XEmptyView.swift
//  XEmptyView
//
//  Created by dianchou on 2020/6/15.
//

import UIKit
import SnapKit
import SwiftGifOrigin
import Lottie
import Kingfisher

// MARK: - 全局属性设置

/// 空状态点击回调闭包定义
public typealias ClickBlock = () -> (Void)

/// 空状态类型枚举
enum XEmptyType {
    case none
    case loading
    case image
    case lottie
    case gif
}

/// 空状态属性值数据Model
public class XEmptyProperty: NSObject {
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
}


// MARK: - EmptyView类
public class XEmptyView: UIView {
    
    // MARK: - 类实例属性
    public var clickBlock: ClickBlock?
    public let imageMaxWidth: CGFloat = UIScreen.main.bounds.size.width - 60
    
    // MARK: - 创建UI页面
    /// 创建EmptyView
    func setupEmptyView(_ p: XEmptyProperty) -> Void {
        // 1.清除控件列表
        self.setupSubViews.removeAllObjects()
        // 2. 添加UI
        switch p.emptyType {
            case .loading: self.setupLoading(p)
            case .lottie: self.setupLottie(p)
            case .image: self.setupImage(p)
            case .gif: self.setupGif(p)
            default: self.clear()
                break
        }
        // 3.添加约束
        self.addConstraints()
        // 4.设置属性
        self.setupProperty(p)
    }
    
    /// 创建Loading指示器
    func setupLoading(_ p: XEmptyProperty) -> Void {
        // 1.添加UI到子控件数组中
        // 1.1 添加指示器
        self.setupSubViews.add(self.indicatorView!)
        // 1.2 添加contentLabel
        if ((p.showContent != nil) && p.showContent!.count > 0) {
            self.setupSubViews.add(self.showContentLabel!)
        }
        // 2.开始动画
        self.indicatorView!.startAnimating()
    }
    
    /// 创建静态图片显示
    func setupImage(_ p: XEmptyProperty) -> Void {
        // 1.添加UI到子控件数组中
        // 1.1 添加指示器
        self.setupSubViews.add(self.animationImageView!)
        // 1.2 添加titleLabel
        if ((p.showTitle != nil) && p.showTitle!.count > 0) {
            self.setupSubViews.add(self.showTitleLabel!)
        }
        // 1.3 添加contentLabel
        if ((p.showContent != nil) && p.showContent!.count > 0) {
            self.setupSubViews.add(self.showContentLabel!)
        }
        // 1.4 添加点击按钮
        if (((p.btnImageFile != nil) && p.btnImageFile!.count > 0) || ((p.btnTitle != nil) && p.btnTitle!.count > 0)) {
            self.setupSubViews.add(self.clickButton!)
        }
    }
    
    /// 创建Lottie动画显示
    func setupLottie(_ p: XEmptyProperty) -> Void {
        // 1.添加UI到子控件数组中
        // 1.1 添加指示器
        self.setupSubViews.add(self.lottieView!)
        // 1.2 添加titleLabel
        if ((p.showTitle != nil) && p.showTitle!.count > 0) {
            self.setupSubViews.add(self.showTitleLabel!)
        }
        // 1.3 添加contentLabel
        if ((p.showContent != nil) && p.showContent!.count > 0) {
            self.setupSubViews.add(self.showContentLabel!)
        }
        // 1.4 添加点击按钮
        if (((p.btnImageFile != nil) && p.btnImageFile!.count > 0) || ((p.btnTitle != nil) && p.btnTitle!.count > 0)) {
            self.setupSubViews.add(self.clickButton!)
        }
    }
    
    /// 创建Gif动画显示
    func setupGif(_ p: XEmptyProperty) -> Void {
        self.setupImage(p)
    }
    
    /// 设置属性
    func setupProperty(_ p: XEmptyProperty) -> Void {
        
        // 设置top距离
        if p.topMargin > 0 {
            self.snp.remakeConstraints { (make) in
                make.top.equalTo(p.topMargin)
                make.left.equalTo(30)
                make.right.equalTo(-30)
            }
        }
        
        // 设置加载指示器的大小属性
        if p.isLarge {
            if #available(iOS 13.0, *) {
                self.indicatorView?.activityIndicatorViewStyle = UIActivityIndicatorView.Style.large
            } else {
                // Fallback on earlier versions
                self.indicatorView?.activityIndicatorViewStyle = UIActivityIndicatorView.Style.gray
            }
        }
        
        // 设置图片文件
        if ((p.imageFile != nil) && p.imageFile!.count > 0) {
            if (p.emptyType == .image) {
                self.animationImageView!.image = UIImage.init(named: p.imageFile!)
            }
            if (p.emptyType == .gif) {
                // 设置动画文件
                self.animationImageView?.loadGif(name: p.imageFile!)
            }
            if (p.emptyType == .lottie) {
                // 设置动画文件
                self.lottieView?.animation = Animation.named(p.imageFile!)
                // 开始动画
                self.lottieView?.play()
            }
        }
        
        // 设置标题
        if ((p.showTitle != nil) && p.showTitle!.count > 0) {
            self.showTitleLabel!.text = p.showTitle
            self.showTitleLabel!.textColor = p.showTitleColor
            self.showTitleLabel!.font = p.showTitleFont
        }
        
        // 设置描述文本
        if ((p.showContent != nil) && p.showContent!.count > 0) {
            self.showContentLabel!.text = p.showContent
            self.showContentLabel!.textColor = p.showContentColor
            self.showContentLabel!.font = p.showContentFont
        }
        
        // 处理宽度属性
        var animationView: UIView? = nil
        if (p.emptyType == .image) {
            animationView = self.animationImageView
        }
        if (p.emptyType == .lottie) {
            animationView = self.lottieView
        }
        if (p.emptyType == .gif) {
            animationView = self.animationImageView
        }
        
        if animationView != nil {
            if ((p.imageWidth != nil) && p.imageWidth! > 0) {
                animationView?.layoutIfNeeded()
                var imageWidth = animationView!.frame.size.width
                imageWidth = p.imageWidth!
                imageWidth = imageWidth > imageMaxWidth ? imageMaxWidth : imageWidth
                
                var imageHeight: CGFloat = 0
                imageHeight = animationView!.frame.size.height * imageWidth / animationView!.frame.size.width
                imageHeight = imageHeight.isNaN ? 0 : imageHeight
                imageHeight = imageHeight.isZero ? imageWidth : imageHeight
                
                animationView?.snp.remakeConstraints({ (make) in
                    make.top.equalTo(0)
                    make.centerX.equalTo(self.snp.centerX)
                    make.width.equalTo(imageWidth)
                    make.height.equalTo(imageHeight)
                })
            }
        }
        
        // 处理按钮显示属性
        if (((p.btnImageFile != nil) && p.btnImageFile!.count > 0) || ((p.btnTitle != nil) && p.btnTitle!.count > 0)) {
            // 优先显示图片
            if ((p.btnImageFile != nil) && p.btnImageFile!.count > 0) {
                // 设置图片
                self.clickButton?.setImage(UIImage.init(named: p.btnImageFile!), for: UIControlState.normal)
            } else if ((p.btnTitle != nil) && p.btnTitle!.count > 0) {
                // 设置文字按钮属性
                self.clickButton?.setTitle(p.btnTitle!, for: UIControlState.normal)
                self.clickButton?.setTitleColor(p.btnTitleColor!, for: UIControlState.normal)
                self.clickButton?.titleLabel?.font = p.btnTitleFont
                self.clickButton?.layer.cornerRadius = 2
                self.clickButton?.layer.masksToBounds = true
                self.clickButton?.layer.borderWidth = 0.5
                self.clickButton?.layer.borderColor = p.btnBorderColor?.cgColor
                
                // 添加宽高约束
                self.clickButton?.snp.makeConstraints({ (make) in
                    make.width.equalTo(p.btnTitleWidth)
                    make.height.equalTo(p.btnTitleHeight)
                })
            }
        }
    }
    
    /// 添加UI约束
    func addConstraints() -> Void {
        if self.setupSubViews.count == 0 {
            return
        }
        
        var lastView: UIView? = nil
        for index in 0...(self.setupSubViews.count-1) {
            let view: UIView = self.setupSubViews[index] as! UIView
            self.addSubview(view)
            if lastView == nil {
                view.snp.makeConstraints { (make) in
                    make.top.equalTo(0)
                    make.centerX.equalTo(self.snp.centerX)
                    make.width.lessThanOrEqualTo(imageMaxWidth)
                }
            }
            if view.isKind(of: UILabel.self) {
                view.snp.makeConstraints { (make) in
                    make.top.equalTo(lastView!.snp.bottom).offset(8)
                    make.left.right.equalTo(0)
                }
            }
            if view.isKind(of: UIButton.self) {
                view.snp.makeConstraints { (make) in
                    make.top.equalTo(lastView!.snp.bottom).offset(20)
                    make.centerX.equalTo(self.snp.centerX)
                }
            }
            lastView = view
        }
        lastView!.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
        }
    }
    
    
    // MARK: - 清除EmptyView
    /// 清除EmptyView
    func clear() -> Void {
        // 清除loadingView
        if self.indicatorView!.isAnimating {
            self.indicatorView!.stopAnimating()
        }
        self.indicatorView!.removeFromSuperview()
        self.indicatorView = nil
    
        // 清除animaintionImageView
        self.animationImageView!.removeFromSuperview()
        self.animationImageView = nil
        
        // 清除标题
        self.showTitleLabel?.removeFromSuperview()
        self.showTitleLabel = nil

        // 清除内容
        self.showTitleLabel?.removeFromSuperview()
        self.showTitleLabel = nil
        
        // 清除
        self.removeFromSuperview()
    }
    
    // MARK: - 按钮点击事件处理
    /// 按钮点击事件
    @objc func clickEvent() -> Void {
        if (self.clickBlock != nil) {
            self.clickBlock!()
        }
    }
    
    // MARK: -  懒加载属性
    /// 添加属性View的列表
    lazy var setupSubViews: NSMutableArray = {
        return NSMutableArray.init()
    }()
    
    /// 显示系统加载指示器
    lazy var indicatorView: UIActivityIndicatorView? = {
        let indicatorView = UIActivityIndicatorView.init()
        if #available(iOS 13.0, *) {
            indicatorView.activityIndicatorViewStyle = UIActivityIndicatorView.Style.medium
        } else {
            // Fallback on earlier versions
            indicatorView.activityIndicatorViewStyle = UIActivityIndicatorView.Style.gray
        }
        return indicatorView
    }()
    
    /// 显示图片、gif
    lazy var animationImageView: UIImageView? = {
        let animationImageView: UIImageView = UIImageView.init()
        animationImageView.contentMode = UIViewContentMode.scaleToFill
        animationImageView.clipsToBounds = true
        return animationImageView
    }()
    
    /// 显示按钮View
    lazy var lottieView: AnimationView? = {
        let lottieView: AnimationView = AnimationView.init()
        lottieView.loopMode = .loop
        lottieView.contentMode = UIViewContentMode.scaleAspectFill;
        lottieView.isUserInteractionEnabled = false;
        return lottieView
    }()
    
    // 标题Label
    lazy var showTitleLabel: UILabel? = {
        let showTitleLabel = UILabel(frame: .zero)
        showTitleLabel.textAlignment = NSTextAlignment.center
        showTitleLabel.numberOfLines = 2
        return showTitleLabel
    }()
    
    // 内容Label
    lazy var showContentLabel: UILabel? = {
        let showContentLabel = UILabel(frame: .zero)
        showContentLabel.textAlignment = NSTextAlignment.center
        showContentLabel.numberOfLines = 10
        return showContentLabel
    }()
    
    /// 显示按钮View
    lazy var clickButton: UIButton? = {
        let clickButton: UIButton = UIButton.init(type: UIButtonType.custom)
        clickButton.addTarget(self, action: #selector(clickEvent), for: UIControlEvents.touchUpInside)
        return clickButton
    }()
}

//
//  XEmptyHelper.swift
//  XEmptyView
//
//  Created by dianchou on 2020/6/15.
//

import UIKit
import SnapKit

public typealias ClearBlock = () -> (Void)
public class XEmptyHelper: NSObject {
    
    // 初始化属性
    public var clearBlock: ClearBlock?
    private var emptyView: XEmptyView? = nil
    private var emptySuperView: UIView?
    
    /// 重载父类初始化方法
    /// - Parameter superView: 设置emptyView的父类
    init(_ superView: UIView) {
        super.init()
        self.emptySuperView = superView
    }
    
    // MARK: - 自定义方法
    /// 显示加载指示器动画
    public func loading(_ block: @escaping (_ p: XEmptyProperty) -> Void) -> Void {
        let p: XEmptyProperty = XEmptyProperty.init()
        block(p);
        p.emptyType = .loading
        addEmptyView(p);
    }
    
    /// 显示静态图片
    public func image(_ block: @escaping (_ p: XEmptyProperty) -> Void) -> Void {
        let p: XEmptyProperty = XEmptyProperty.init()
        block(p);
        p.emptyType = .image
        addEmptyView(p);
    }
    
    /// 显示Gif
    public func gif(_ block: @escaping (_ p: XEmptyProperty) -> Void) -> Void {
        let p: XEmptyProperty = XEmptyProperty.init()
        block(p);
        p.emptyType = .gif
        addEmptyView(p);
    }
    
    /// 显示Lottie
    public func lottie(_ block: @escaping (_ p: XEmptyProperty) -> Void) -> Void {
        let p: XEmptyProperty = XEmptyProperty.init()
        block(p);
        p.emptyType = .lottie
        addEmptyView(p);
    }
    
    /// 清除空状态页
    public func clear() -> Void {
        if self.emptyView != nil {
            self.emptyView?.clear()
            self.emptyView?.removeFromSuperview()
            self.emptyView = nil
            self.emptySuperView = nil
            self.clearBlock?()
            self.clearBlock = nil
        }
    }
    
    /// 添加空状态页
    func addEmptyView(_ p: XEmptyProperty) -> Void {
        // 1.清除
        clear()
        
        // 2.创建emptyView
        self.emptyView = XEmptyView.init()
        self.emptyView?.clickBlock = { () in
            p.clickBlock!()
        }
        self.emptySuperView?.addSubview(self.emptyView!)
        self.emptyView?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.emptySuperView!.snp.center)
            make.width.equalTo(UIScreen.main.bounds.size.width - 60)
        })

        // 3.设置属性值
        self.emptyView?.setupEmptyView(p)
    }
}

//
//  XEmptyExtension.swift
//  XEmptyView
//
//  Created by dianchou on 2020/6/15.
//

import Foundation

public extension UIView {
    
    var ep: XEmptyHelper {
        if (self.helper == nil) {
            // 初始化
            self.helper = XEmptyHelper.init(self)
            // 闭包内释放helper属性
            weak var weakSelf = self
            self.helper?.clearBlock = {() in
                weakSelf?.helper = nil
            }
        }
        return self.helper!
    }
    
    
    // 关联属性的Keys列表
    private struct Keys {
        static var emptyHelperKey: String = "x-emptyHelper"
    }
    private var helper: XEmptyHelper? {
        set {
            objc_setAssociatedObject(self, &Keys.emptyHelperKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let obj = objc_getAssociatedObject(self, &Keys.emptyHelperKey) as? XEmptyHelper else { return nil }
            return obj
        }
    }
}




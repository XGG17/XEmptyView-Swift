//
//  ViewController.swift
//  XEmptyView
//
//  Created by xiang on 12/09/2020.
//  Copyright (c) 2020 xiang. All rights reserved.
//

import UIKit
import XEmptyView

class ViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    
    @IBAction func loadingEvent(_ sender: Any) {
        // loading
        self.mainView.isHidden = true
        self.view.ep.loading { (p) in
//            p.isLarge = true
            p.showContent = "加载中..."
        }
        
        self.closeEmptyView()
    }
    
    @IBAction func lottieAnimationEvent(_ sender: Any) {
        // lottie
        self.mainView.isHidden = true
        self.view.ep.lottie { (p) in
            p.imageFile = "empty-lottie"
            p.showTitle = "这里是标题"
            p.showContent = "这里是描述文本这里是描述文本这里是描述文本里是描述文本这里是描述文本这里是描述文本"
        }
        
        self.closeEmptyView()
    }
    
    @IBAction func gifAnimationEvent(_ sender: Any) {
        // Gif
        self.mainView.isHidden = true
        self.view.ep.gif { (p) in
            p.imageFile = "empty-gif"
            p.imageWidth = 120
            p.showTitle = "这里是标题"
            p.showContent = "这里是描述文本这里是描述文本这里是描述文本里是描述文本这里是描述文本这里是描述文本"
            p.btnImageFile = "empty_reload"
            p.clickBlock = { () in
                print("gif点击刷新")
            }
        }
        
        self.closeEmptyView()
    }
    
    @IBAction func normalImageEvent(_ sender: Any) {
        // image
        self.mainView.isHidden = true
        self.view.ep.image { (p) in
            p.imageFile = "empty_no_network"
            p.showTitle = "这里是标题这里是标题"
            p.showContent = "这里是描述文本这里是描述文本这里是描述文本里是描述文本这里是描述文本这里是描述文本这里是描述文本这里是描述文本"
            p.btnTitle = "点击刷新"
            p.clickBlock = { () in
                print("静态图片点击刷新")
            }
        }

        self.closeEmptyView()
    }
    
    func closeEmptyView() -> Void {
        // 模拟3秒钟时候关闭
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.mainView.isHidden = false
            self.view.ep.clear()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


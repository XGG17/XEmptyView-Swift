
Pod::Spec.new do |s|
  s.name             = 'XEmptyView'
  s.version          = '1.0.0'
  s.swift_versions   = '5.0'
  s.summary          = 'Swift空状态加载、提示页面'
  s.description      = <<-DESC
    Swift空状态加载、提示View，支持系统加载指示器Loading加载，Lottie(Json)动画加载，Gif动画加载以及静态图片展示，依赖SnapKit SwiftGifOrigin lottie-ios 等第三方框架
                       DESC
  s.homepage         = 'https://github.com/xgg17'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiang' => '2559818083@qq.com' }
  s.source           = { :git => 'https://github.com/XGG17/XEmptyView-Swift.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'XEmptyView/Classes/**/*'

  # 添加依赖
  s.dependency 'SnapKit'
  s.dependency 'SwiftGifOrigin'
  s.dependency 'lottie-ios'
end

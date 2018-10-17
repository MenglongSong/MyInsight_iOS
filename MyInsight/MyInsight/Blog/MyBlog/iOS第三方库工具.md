#  iOS第三方库工具

### CocoaPods



更新仓库
`pod update`
`pod update --verbose`
更新所有的仓库
`pod repo update --verbose`
更新制定的仓库
`pod update ** --verbose --no-repo-update`



### [Carthage](https://github.com/Carthage/Carthage)
目标：Carthage旨在使用最简单的方式来管理Cocoa框架。
原理：自动将第三方框架编译为动态库(Dynamic framework)
优点：Carthage为用户管理第三方框架和依赖，但不会自动修改项目文件或构建设置，开发者可以完全控制项目结构和设置
缺点：只支持iOS 8.0+，不能用来开发iOS 8.0以前的项目


使用Carthage
1. 先进入项目所在的文件夹
`cd '项目路径'`
2. 创建一个Carthage空文件
`touch Cartfile`
3. 编辑Cartfile文件，例如要安装MBProgressHUD框架
`github "jdg/MBProgressHUD" ~> 1.0.0`
4. 保存并关闭Cartfile文件，使用Carthage安装框架
`carthage update`

### 参考：
[CocoaPods使用总结](https://www.jianshu.com/p/7d0ad4cde012)


[Carthage 的使用——iOS第三方库的管理](https://www.jianshu.com/p/f33972b08648)

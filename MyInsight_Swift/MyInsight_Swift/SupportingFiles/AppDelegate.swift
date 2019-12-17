//
//  AppDelegate.swift
//  MyInsight_Swift
//
//  Created by SongMengLong on 2018/7/16.
//  Copyright © 2018年 SongMengLong. All rights reserved.
//

import UIKit
import PushKit
import Alamofire
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let manager = NetworkReachabilityManager(host: "https://github.com/Alamofire/Alamofire.git")
    // 关键字设置
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        debugPrint("程序启动完成")
        
        //AFNetworkReachabilityManager.shared().startMonitoring()
        //AppBackgroundService()
        
        let manager = NetworkReachabilityManager(host: "https://github.com/Alamofire/Alamofire.git")
        
        manager?.listener = { status in
            switch status {
            case .notReachable:
                print("网络状态判断 notReachable")
            case .unknown:
                print("网络状态判断 unknown")
            case .reachable(.ethernetOrWiFi):
                print("网络状态判断 ethernetOrWiFi")
            case .reachable(.wwan):
                print("网络状态判断 wwan")
            }
            
            // 发送通知
        }
        // 开始监听网络
        manager?.startListening()
        
        
        // 设置3D Touch
        self.setup3DTouch()
        
        // 判断应用是否是第一次启动
        self.isRightFirstLaunched()
        
        // 注册VOIP
        //self.voipRegistration()
        
        return true
    }
    
    //MARK: - 判断是否为首次启动
    func isRightFirstLaunched() -> Void {
        /*
         若是第一次加载，进入欢迎页面，若不是直接进入主页面
         */
        let userDefaults: UserDefaults = UserDefaults.standard;
        debugPrint("是不是第一次启动")
        
        if (userDefaults.string(forKey: "LauchAgree") == nil) {
            userDefaults.set(true, forKey: "LauchAgree")
            debugPrint("首次启动 进入欢迎页面")
            
            let welcomeVC: WelcomeVC = WelcomeVC()
            self.window?.rootViewController = welcomeVC
        } else {
            debugPrint("不是首次启动 进入主页面")
            let mainRevealVC: MainRevealVC = MainRevealVC()
            
            self.window?.rootViewController = mainRevealVC
        }
    }
    
    func setup3DTouch() {
        debugPrint("你说是啥就是啥")
        // Swift开发之3DTouch实用演练 http://www.sohu.com/a/200417763_208051
        let homeIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.compose)
        let homeItem = UIApplicationShortcutItem(type: "homeAnchor", localizedTitle: "首页", localizedSubtitle: "点击进入首页", icon: homeIcon, userInfo: nil)
        
        let playIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.play)
        let playItem = UIApplicationShortcutItem(type: "homeAnchor", localizedTitle: "播放", localizedSubtitle: "开始点播了", icon: playIcon, userInfo: nil)
        
        let userIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.search)
        let userItem = UIApplicationShortcutItem(type: "homeAnchor", localizedTitle: "用户名", localizedSubtitle: "你爸爸是谁", icon: userIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [homeItem, playItem, userItem]
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        debugPrint("WillResignActive 程序将要进入后台")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        debugPrint("DidEnterBackground 程序进入后台")
    }
    
    func voipRegistration() -> Void {
        // dispatch_get_main_queue
        let mainQueue = DispatchQueue.main
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
        
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        debugPrint("WillEnterForeground 程序将要进入前台")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        debugPrint("BecomeActive 程序进入前台")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        debugPrint("WillTerminate 程序退出")
    }
    
}

// VOIP 推送
extension AppDelegate: PKPushRegistryDelegate {
    /*
     [iOS后台唤醒实战：微信收款到账语音提醒技术总结](https://www.jianshu.com/p/68eed9442d2c)
     [Voice Over IP (VoIP) Best Practices](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/OptimizeVoIP.html)
     */
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
    }
}


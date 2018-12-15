//
//  LLBlueTooth.swift
//  LLBlueTooth
//
//  Created by SongMenglong on 2018/12/15.
//  Copyright © 2018 gemvary. All rights reserved.
//

//import UIKit
import CoreBluetooth

open class LLBlueTooth: NSObject {
    
    // 初始化蓝牙单例
    @objc public static let shared = LLBlueTooth()
    // 初始化变量
    var centralManager: CBCentralManager?

    // 声明
    private override init() {}
    
    override open func copy() -> Any {
        return self
    }

    override open func mutableCopy() -> Any {
        return self
    }
    
    // 重置
    func reset() -> Void {

    }
    
    // 初始化蓝牙管理者
    open func initCentralManager() -> Void {
        // [CBCentralManagerOptionShowPowerAlertKey: false]
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
    
    // 扫描时间
    open func scanForPeripheralsWithTime(time: TimeInterval) -> Void {
        
        debugPrint("延时操作 准备")
        // 开始扫描
        //centralManager!.scanForPeripherals(withServices: nil, options: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {

            debugPrint("延时三秒结束")
            // 停止扫描
            self.centralManager?.stopScan()

        }
        debugPrint("操作111")
    }
    
}


// 实现代理协议
extension LLBlueTooth: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // 蓝牙状态改变
        debugPrint("蓝牙设备状态变化", central.state.rawValue)
        centralManager!.scanForPeripherals(withServices: nil, options: nil)
    }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // 发现蓝牙设备
        debugPrint("发现蓝牙设备", peripheral, advertisementData, RSSI)
    }
    
    private func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // 连接上蓝牙设备
        
    }
    
    private func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        //
    }
    
    private func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        //
    }

}







/*
 单例模式
 https://www.cnblogs.com/silence-cnblogs/p/6776217.html
 */


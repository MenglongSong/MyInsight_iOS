//
//  BasicVC.swift
//  MyInsight_Swift
//
//  Created by SongMengLong on 2018/7/22.
//  Copyright © 2018年 SongMengLong. All rights reserved.
//

import UIKit
import SWRevealViewController
import ContactsUI
//import cont

class BasicVC: BaseVC {
    let RunTimeStr = "RunTime"
    let ClosureStr = "Closure"
    let GRDBStr = "GRDB数据库"
    let AES_Crypto = "AES加密"
    let GCD_Group = "GCD调度组"
    let WifiInfo = "WiFi信息"
    let DatePick = "日期选择"
    let TimePick = "时间选择"
    
    // 声明变量
    let tableview = UITableView()
    // 数组
    fileprivate lazy var dataArray = { () -> [String] in
        let array = [RunTimeStr, ClosureStr, GRDBStr, AES_Crypto, GCD_Group, WifiInfo, DatePick, TimePick]
        return array
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 设置抽屉手势
        if self.revealViewController() != nil {
            self.revealViewController().tapGestureRecognizer()
           // 添加手势动作
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置抽屉手势
        if self.revealViewController() != nil {
            // 移除掉手势动作
        self.view.removeGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 左右button 设置抽屉
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "左边", style: UIBarButtonItem.Style.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:))) //revealToggle(_:)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "右边", style: UIBarButtonItem.Style.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)))
        
        self.view.backgroundColor = UIColor.white
        self.tableview.backgroundColor = UIColor.white
        
        // 可以写swift的一些特性
        let name: String? = "老王"
        
        let name1:String? = nil
        
        // ?? 运算符的优先级低于 +号，注意使用的时候加上括号啊
        
        print(name ?? "" + "你好")
        
        print(name1 ?? "" + "你好")
        
        // 初始化tableview
        self.view.addSubview(self.tableview)
        self.tableview.frame = self.view.bounds;
        self.tableview.delegate = self
        self.tableview.dataSource = self
        // 注册cell
        self.tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        // 清空多余cell
        self.tableview.tableFooterView = UIView(frame: CGRect.zero)
        
//        dataArray = [RunTimeStr, ClosureStr, GRDBStr, AES_Crypto, GCD_Group, WifiInfo]
        // 303030434246324335453435
        // hex值转换十六进制
        let str: String = String(data: Data(hex: "303030434246324335453435"), encoding: String.Encoding.utf8)!
        
        debugPrint("转换后的字符串内容", str)
        
        var tempStr = ""
        
//        for index in 0...5 {
//            print("\(index) 乘于 5 为：\(index * 5)")
//            // str = str + string.substring(with: NSMakeRange(0,2)).uppercased()
//            tempStr = tempStr + str.prefix(upTo: <#T##String.Index#>)
//        }
        
        
        let x = "000CBF2C5E45"
        
        var newText = String()
        for (index, character) in x.enumerated() {
            if index != 0 && index % 2 == 0 {
                newText.append(":")
            }
            newText.append(String(character))
        }
        print(newText)
        
        
        let s = "000CBF2C5E45"
        let r = String(s.enumerated().map { $0 > 0 && $0 % 2 == 0 ? [":", $1] : [$1]}.joined())
        
        print(r)
        
        
        
        let ssss = String(64, radix: 2, uppercase: true)
        debugPrint("这是什么？", ssss)
        
        debugPrint("准备转换的数据", strtol(ssss, nil, 2))
        
        var testStrr = "001101" //String(strtol(ssss, nil, 2))
        
        
        for _ in 1...7-testStrr.count {
            testStrr = "0" + testStrr
        }
        debugPrint("解析后的字符串", testStrr)
        debugPrint("准备转换的数据", strtol(testStrr, nil, 2))
        
        
        // 转换时间戳
        let nowDate = CLongLong(round(Date().timeIntervalSince1970 * 1000)) //Int(Date().timeIntervalSince1970)
        debugPrint("当前的时间戳", nowDate)
        debugPrint("当前的时间戳字符串", nowDate.description)
        
//        debugPrint(<#T##items: Any...##Any#>)
        
        debugPrint("核对车牌是否正确", self.checkCarID(carID: "龙A23444"))
        debugPrint("核对车牌是否正确", self.checkCarID(carID: "粤A234I4"))
        debugPrint("核对车牌是否正确", self.checkCarID(carID: "粤A234O4"))
        debugPrint("核对车牌是否正确", self.checkCarID(carID: "粤A2B444"))
        
    }
    
    
    
    /*
     +(BOOL)checkCarID:(NSString *)carID;
     {
         if (carID.length==7) {
            //普通汽车，7位字符，不包含I和O，避免与数字1和0混淆
            NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}[a-hj-np-zA-HJ-NP-Z0-9\u4e00-\u9fa5]$";
            NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
            return [carTest evaluateWithObject:carID];
         }else if(carID.length==8){
            //新能源车,8位字符，第一位：省份简称（1位汉字），第二位：发牌机关代号（1位字母）;
            //小型车，第三位：只能用字母D或字母F，第四位：字母或者数字，后四位：必须使用数字;([DF][A-HJ-NP-Z0-9][0-9]{4})
            //大型车3-7位：必须使用数字，后一位：只能用字母D或字母F。([0-9]{5}[DF])
            NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}([0-9]{5}[d|f|D|F]|[d|f|D|F][a-hj-np-zA-HJ-NP-Z0-9][0-9]{4})$";
            NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
            return [carTest evaluateWithObject:carID];
         }
         return NO;
     }
     */
    
    
    func checkCarID(carID: String) -> Bool {
        if carID.count == 7 {
            // 普通汽车，7位字符，不包含I和O，避免与数字1和0混淆
            // ^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$
            
            let carRegex: String = "^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}[a-hj-np-zA-HJ-NP-Z0-9挂学警港澳]$"
            //let carRegex: String = "^[\\u4e00-\\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}[a-hj-np-zA-HJ-NP-Z0-9\\u4e00-\\u9fa5]$"
            let carTest =  NSPredicate(format: "SELF MATCHES %@", carRegex)
            return carTest.evaluate(with: carID)
        } else if carID.count == 8 {
            //新能源车,8位字符，第一位：省份简称（1位汉字），第二位：发牌机关代号（1位字母）;
            //小型车，第三位：只能用字母D或字母F，第四位：字母或者数字，后四位：必须使用数字;([DF][A-HJ-NP-Z0-9][0-9]{4})
            //大型车3-7位：必须使用数字，后一位：只能用字母D或字母F。([0-9]{5}[DF])
            let carRegex: String = "^[\\u4e00-\\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}([0-9]{5}[d|f|D|F]|[d|f|D|F][a-hj-np-zA-HJ-NP-Z0-9][0-9]{4})$"
            let carTest =  NSPredicate(format: "SELF MATCHES %@", carRegex)
            return carTest.evaluate(with: carID)
        }
        
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - 实现协议
extension BasicVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // cell行数目
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        // label赋值
        cell.textLabel?.text = dataArray[indexPath.row]
        // 箭头
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    // 选中cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellStr: String = self.dataArray[indexPath.row]
                
        if cellStr == RunTimeStr {
            // RunTime运行时
            let runTimeVC :RunTimeVC = RunTimeVC()
            runTimeVC.title = RunTimeStr
            runTimeVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(runTimeVC, animated: true)
        }
        if cellStr == ClosureStr {
            // 闭包
            let closureVC: ClosureVC = ClosureVC()
            closureVC.title = ClosureStr
            closureVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(closureVC, animated: true)
        }
        if cellStr == GRDBStr {
            // GRDB数据库
            let grdbVC: GRDBVC = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GRDBVC") as? GRDBVC)!
            grdbVC.title = GRDBStr
            grdbVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(grdbVC, animated: true)
        }
        if cellStr == AES_Crypto {
            // AES加密
            let aesVC = CryptoAESVC()
            aesVC.title = AES_Crypto
            aesVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(aesVC, animated: true)
        }
        if cellStr == GCD_Group {
            // GCD调度组
            let gcdGroupVC = GCDGroupVC()
            gcdGroupVC.title = GCD_Group
            gcdGroupVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(gcdGroupVC, animated: true)
        }
        if cellStr == WifiInfo {
            // Wi-Fi信息
            let wifiInfoVC = WifiInfoVC()
            wifiInfoVC.title = WifiInfo
            wifiInfoVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(wifiInfoVC, animated: true)
        }
        if cellStr == DatePick {
            // 日期选择
            let datePickerVC = DatePickerVC()
            datePickerVC.hidesBottomBarWhenPushed = true
            //self.navigationController?.pushViewController(datePickerVC, animated: true)
            
            datePickerVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            datePickerVC.datePickerBlock = { limitDate in
//                debugPrint("时间日期选择器返回的闭包", limitDate)
//                let dateFormatter = DateFormatter.init()
//                dateFormatter.dateFormat = "yyyy年MM月dd日"
//                dateFormatter.timeZone = TimeZone.current
//                let timeStr2: String = dateFormatter.string(from: limitDate)
//                debugPrint("当前时区的时间", timeStr2)
            }
            self.present(datePickerVC, animated: true) {
                
            }
        }
        if cellStr == TimePick {
            // 时间选择
            let timePickerVC = TimePickerVC()
            timePickerVC.hidesBottomBarWhenPushed = true
            //self.navigationController?.pushViewController(timePickerVC, animated: true)
            timePickerVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            
            timePickerVC.timePickerBlock = { beginTime, endTime in
                debugPrint("开始时间， 结束时间", beginTime, endTime)
                let dateFormatter = DateFormatter.init()
                dateFormatter.dateFormat = "HH:mm"
                dateFormatter.timeZone = TimeZone.current
                let timeStr1: String = dateFormatter.string(from: beginTime)
                let timeStr2: String = dateFormatter.string(from: endTime)
                debugPrint("打印时间1", timeStr1)
                debugPrint("打印时间2", timeStr2)
            }
            
//            self.present(timePickerVC, animated: true) {
//
//            }
            
            self.addNewContact()
        }
    }
        
    
    /// 添加新联系人
    func addNewContact() -> Void {
        // 创建Contact对象，必须是可变的
        let contact: CNMutableContact = CNMutableContact()
        // 为contact赋值

        // 新建好友页面
        let contactVC = CNContactViewController(forNewContact: contact)
        // 设置代理
        contactVC.delegate = self as CNContactViewControllerDelegate
        // 设置navi视图
        let naviVC = UINavigationController(rootViewController: contactVC)
        // 转页面
        //
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true, completion: nil)
    }
    
    
    
}


extension BasicVC: CNContactViewControllerDelegate {
    // 实现代理方法
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

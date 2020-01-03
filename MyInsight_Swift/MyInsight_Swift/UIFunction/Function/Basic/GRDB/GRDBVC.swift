//
//  GRDBVC.swift
//  MyInsight_Swift
//
//  Created by SongMenglong on 2019/3/31.
//  Copyright © 2019 SongMengLong. All rights reserved.
//

import UIKit
import GRDB

//let dbQueue = try DatabaseQueue(path: "/path/to/database.sqlite")
//let dbPool = try DatabasePool(path: "/path/to/database.sqlite")

/// 数据库
class GRDBVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
    
    // MARK: 创建数据库
    @IBAction func createTableAction(_ sender: UIButton) {
        debugPrint("创建数据库")
        
        
    }
    
    // MARK: 添加数据
    @IBAction func addDataAction(_ sender: UIButton) {
        debugPrint("添加数据")
        
        let stu = Student(name: "张三", nick_name: "哈皮", age: 30, gender: true)
        Student.insert(student: stu)
    }
    
    // MARK: 删除数据
    @IBAction func deleteDataAction(_ sender: UIButton) {
        debugPrint("删除数据")
        
        
        
    }
    
    // MARK: 更改数据
    @IBAction func changeDataAction(_ sender: UIButton) {
        debugPrint("更改数据")
    }
    
    // MARK: 查询数据
    @IBAction func queryDataAction(_ sender: UIButton) {
        debugPrint("查询数据")
        
        debugPrint("查询所有数据:", Student.queryAll())
    }
    
    // MARK: 关闭数据库
    @IBAction func closeTableAction(_ sender: UIButton) {
        debugPrint("关闭数据库")
    }
    
    
}

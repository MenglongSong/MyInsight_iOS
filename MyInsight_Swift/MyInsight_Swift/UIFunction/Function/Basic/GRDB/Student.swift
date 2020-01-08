//
//  Student.swift
//  MyInsight_Swift
//
//  Created by MenglongSong on 2020/1/3.
//  Copyright © 2020 SongMengLong. All rights reserved.
//

import GRDB

/// 学生类
struct Student: Codable {
    /// 名字
    var name: String?
    /// 昵称
    var nick_name: String?
    /// 年龄
    var age: Int?
    /// 性别
    var gender: Bool?
    
    /// 设置行名
    private enum Columns: String, CodingKey, ColumnExpression {
        /// 名字
        case name
        /// 昵称
        case nick_name
        /// 年龄
        case age
        /// 性别
        case gender
    }
}

extension Student: MutablePersistableRecord, FetchableRecord {
    /// 获取数据库对象
    private static let dbQueue = DBManager.dbQueue
    
    //MARK: 创建
    /// 创建数据库
    private static func createTable() -> Void {
        try! self.dbQueue.write { (db) -> Void in
            // 判断是否存在数据库
            if try db.tableExists(TableName.student) {
                //debugPrint("表已经存在")
                return
            }
            // 创建数据库表
            try db.create(table: TableName.student, temporary: false, ifNotExists: true, body: { (t) in
                // ID
                t.column(Columns.name.rawValue, Database.ColumnType.text)
                // 名字
                t.column(Columns.nick_name.rawValue, Database.ColumnType.text)
                // 朝代
                t.column(Columns.age.rawValue, Database.ColumnType.integer)
                // 简介
                t.column(Columns.gender.rawValue, Database.ColumnType.boolean)
            })
        }
    }
    
    //MARK: 插入
    /// 插入单个数据
    static func insert(student: Student) -> Void {
        // 判断是否存在
        guard Student.query(name: student.name!) == nil else {
            debugPrint("插入学生 内容重复")
            // 更新
            self.update(student: student)
            return
        }
        
        // 创建表
        self.createTable()
        // 事务
//        try! self.dbQueue.inTransaction { (db) -> Database.TransactionCompletion in
//            do {
//                var studentTemp = student
//                // 插入到数据库
//                try studentTemp.insert(db)
//                return Database.TransactionCompletion.commit
//            } catch {
//                return Database.TransactionCompletion.rollback
//            }
//        }
        
        try! self.dbQueue.write({ (db) -> Void in
            var studentTemp = student
            try studentTemp.insert(db)
        })

    }
    
    //MARK: 查询
    static func query(name: String) -> Student? {
        // 创建数据库
        self.createTable()
        // 返回查询结果
        return try! self.dbQueue.unsafeRead({ (db) -> Student? in
            return try Student.filter(Column(Columns.name.rawValue) == name).fetchOne(db)
        })
    }
    
    /// 查询所有
    static func queryAll() -> [Student] {
        // 创建数据库
        self.createTable()
        // 返回查询结果
        return try! self.dbQueue.unsafeRead({ (db) -> [Student] in
            return try Student.fetchAll(db)
        })
    }
    
    //MARK: 更新
    /// 更新
    static func update(student: Student) -> Void {
        /// 创建数据库表
        self.createTable()
        // 事务 更新场景
//        try! self.dbQueue.inTransaction { (db) -> Database.TransactionCompletion in
//            do {
//                // 赋值
//                try student.update(db)
//                return Database.TransactionCompletion.commit
//            } catch {
//                return Database.TransactionCompletion.rollback
//            }
//        }
        
//        try! self.dbQueue.writeInTransaction({ (db) -> Database.TransactionCompletion in
//            do {
//                // 赋值
//                try student.update(db)
//                return Database.TransactionCompletion.commit
//            } catch {
//                return Database.TransactionCompletion.rollback
//            }
//        })
        
        try! self.dbQueue.writeInTransaction{ (db) -> Database.TransactionCompletion in
            do {
                // 赋值
                try student.update(db)
                return Database.TransactionCompletion.commit
            } catch {
                return Database.TransactionCompletion.rollback
            }
        }
        
        
        
//        try! self.dbQueue.write({ (db) -> Void in
//            try student.update(db)
//        })
    }
    
    //MARK: 删除
    /// 根据名字删除学生
    static func delete(name: String) -> Void {
        // 查询
        guard let student = self.query(name: name) else {
            return
        }
        // 删除
        self.delete(student: student)
    }
    
    /// 删除单个学生
    static func delete(student: Student) -> Void {
        // 是否有数据库表
        self.createTable()
        // 事务
//        try! self.dbQueue.inTransaction { (db) -> Database.TransactionCompletion in
//            do {
//                // 删除数据
//                try student.delete(db)
//                return Database.TransactionCompletion.commit
//            } catch {
//                return Database.TransactionCompletion.rollback
//            }
//        }
        
        try! self.dbQueue.write({ (db) -> Void in
            try student.delete(db)
        })
        
        
    }
}

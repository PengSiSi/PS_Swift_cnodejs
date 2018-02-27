//
//  SQLiteDatabase.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/26.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import Foundation
import SQLite3

// 数据库用于保存浏览历史，可以查看浏览历史 如果一个帖子已经查看在帖子列表页面此帖子标题灰色显示
public class SQLiteDatabase {
    private let TABLE_READ_HISTORY = "readHistory"
    
    fileprivate static var db: SQLiteDatabase?
    fileprivate let dbPointer: OpaquePointer?
    
    fileprivate init(dbPointer: OpaquePointer?) {
        self.dbPointer = dbPointer
    }
    
    deinit {
        log.info("deinit sqlite3 db")
        sqlite3_close(dbPointer)
    }
    
    public static func initDatabase() {
        DispatchQueue.global(qos: .background).async {
            log.info("init database")
            do {
                try SQLiteDatabase.instance?.createTables()
                try SQLiteDatabase.instance?.clearOldHistory(max: 2000) //最多存2000条
            } catch {
                log.error(error)
            }
        }
    }
    
    // 单例 创建数据库
    public static var instance: SQLiteDatabase? {
        if SQLiteDatabase.db == nil {
            guard let documnetDirectoryURL = try?
                FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)  else {
                    return nil
            }
            let dirURL = documnetDirectoryURL.appendingPathComponent("database")
            let fileURL = dirURL.appendingPathComponent("cnodejs.db")
            
            if !FileManager.default.fileExists(atPath: dirURL.path) {
                try? FileManager.default.createDirectory(at: dirURL, withIntermediateDirectories: true, attributes: nil)
                log.verbose("success create db dir:\(dirURL.path)")
            }
            
            try? SQLiteDatabase.db = SQLiteDatabase.open(path: fileURL.path)
        }
        return SQLiteDatabase.db
    }
    
    // 打开数据库
    
    public static func open(path: String) throws -> SQLiteDatabase {
        var db: OpaquePointer? = nil
        if sqlite3_open(path, &db) == SQLITE_OK {
            return SQLiteDatabase(dbPointer: db)
        } else {
            // defer在函数结束前执行
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }
            if let errPointer = sqlite3_errmsg(db) {
                let message = String(cString: errPointer)
                throw SQLiteError.OpenDatabase(message: message)
            } else {
                throw SQLiteError.OpenDatabase(message: "No error message provided from sqlite.")
            }
        }
    }
    
    // 关闭数据库
    public static func close() {
        if SQLiteDatabase.db != nil {
            SQLiteDatabase.db = nil
        }
    }
    
    // 数据库出错信息
    public var errorMessage: String {
        if let errorPointer = sqlite3_errmsg(dbPointer) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else {
            return "No error message provided from sqlite."
        }
    }
    
    // prepare
    private func prepare(statement sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer? = nil
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: errorMessage)
        }
        
        return statement
    }
    
    // 执行sql语句
    public func excute(sql: String) throws {
        let statement = try prepare(statement: sql)
        defer {
            sqlite3_finalize(statement)
        }
        guard sqlite3_step(statement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        log.verbose("success excute sql:\n\(sql)")
    }
    
    // 创建表
    func createTables() throws {
        let tbHistorySql = """
        CREATE TABLE IF NOT EXISTS \(TABLE_READ_HISTORY) (
        tid INTEGER primary key,
        title TEXT NOT NULL)
        """
        try excute(sql: tbHistorySql)
        log.verbose("success create table: \n\(TABLE_READ_HISTORY)")
    }
    
    // 新增，更新
    func addHistory(tid: Int, title: String) {
        let sql = """
        REPLACE INTO \(TABLE_READ_HISTORY)(tid,title) VALUES (?,?)
        """
        guard let statemet = try? prepare(statement: sql) else {
            log.error(errorMessage)
            return
        }
        defer {
            sqlite3_finalize(statemet)
        }
        guard sqlite3_bind_int(statemet, 1, Int32(tid)) == SQLITE_OK &&
            sqlite3_bind_text(statemet, 2, NSString(string: title).utf8String, -1, nil) == SQLITE_OK else {
                log.error(errorMessage)
                return
        }
        
        guard sqlite3_step(statemet) == SQLITE_DONE else {
            log.error(errorMessage)
            return
        }
        
        log.verbose("Successfully inserted history row.")
    }
    
    // 判断model是否为已读并修改返回
    func setReadHistory(items: [ItemModel]) -> [ItemModel] {
        var `items` = items
        let sql = "SELECT * from \(TABLE_READ_HISTORY) where tid = ?"
        guard let statement = try? prepare(statement: sql) else {
            return items
        }
        defer {
            sqlite3_finalize(statement)
        }
        for (offset, item) in items.enumerated() {
            guard let itemID = Int(item.itemID!) else {
                continue
            }
            let tid = Int32(itemID)
            sqlite3_reset(statement)
            guard sqlite3_bind_int(statement, 1, tid) == SQLITE_OK else {
                log.error("bind error \(errorMessage)")
                continue
            }
            guard sqlite3_step(statement) == SQLITE_ROW else {
                continue
            }
            items[offset].isRead = true
        }
        return items
    }
    
    // 加载浏览历史
    func loadReadHistory(count: Int) -> [ItemModel] {
        var items = [ItemModel]()
        let sql = "SELECT * FROM \(TABLE_READ_HISTORY) order by tid desc limit \(count)"
        guard let statement = try? prepare(statement: sql) else {
            return items
        }
        
        defer {
            sqlite3_finalize(statement)
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            let tid = Int(sqlite3_column_int(statement, 0))
            let title = String(cString: sqlite3_column_text(statement, 1))
            
            items.append(ItemModel(itemID: tid.description, title: title))
        }
        log.verbose(items.count)
        return items
    }
    
    // 删除浏览历史
    func deleteHistory(itemID: Int) throws {
        let sql = "DELETE FROM \(TABLE_READ_HISTORY) WHERE tid = \(itemID)"
        try excute(sql: sql)
    }
    
    // 清空所有浏览记录
    func clearHistory() throws {
        let sql = "DELETE FROM \(TABLE_READ_HISTORY)"
        try excute(sql: sql)
    }
    
    // 浏览历史到了一定数量以后需要删除老的数据
    func clearOldHistory(max: Int) throws {
        let sql = "SELECT COUNT(*) FROM \(TABLE_READ_HISTORY)"
        let statement = try prepare(statement: sql)
        defer{
            sqlite3_finalize(statement)
        }
        guard sqlite3_step(statement) == SQLITE_ROW else {
            throw SQLiteError.Step(message: errorMessage)
        }
        
        let count = Int(sqlite3_column_int(statement, 0))
        if count <= max {
            return
        }
        
        let deletes = count / 4
        let deleteSql = "DELETE FROM \(TABLE_READ_HISTORY) ORDER BY created asc limit \(deletes)"
        try excute(sql: deleteSql)
    }
    
    // 删除所有的表
    func dropTables() throws {
        let dropSql = "DROP TABLE IF EXISTS \(TABLE_READ_HISTORY)"
        try excute(sql: dropSql)
        log.verbose("success drop table:\(TABLE_READ_HISTORY)")
    }
}

//
//  SuperDatabaseManager.swift
//  数据库管理器
//  主要是对外提供更高层次接口，例如：查询音乐，保存音乐
//  当然真实项目中，如果业务比较复杂，可以像网络那样，在封装一层
//  例如：DatabaseManager对外隔离具体数据；SongLocalRepository对外提供音乐本地保存，查询
//
//  Created by Tao on 2025/12/24.
//

import Foundation

//腾讯开源的数据库框架
import WCDBSwift

class SuperDatabaseManager {
    private static var instance:SuperDatabaseManager?
    
    open class var shared: SuperDatabaseManager {
        get {
            if instance == nil {
                instance = SuperDatabaseManager()
            }
            
            return instance!
        }
    }
    
    /// 数据库对象
    var database:Database!
    
    private init() {
        innerInit()
        initTable()
    }
    
    func innerInit() {
        //创建数据库
        //获取沙盒根目录
        let documentsPath=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
        //数据库名称，添加用户id，这样就隔离了不同用户数据
        //当然也可以数据中存用户id
        let databaseName = "\(PreferenceUtil.getUserId()).db"
        
        // 数据库文件路径
        let databasePath=documentsPath.appendingPathComponent(databaseName)
        
        print("database path \(databasePath)")
        
        //创建数据库
        database=Database(withPath: databasePath)
    }
    
    // MARK: - 创建表
    func initTable() {
        //创建表
        try! database.create(table: SearchHistory.NAME, of: SearchHistory.self)
        try! database.create(table: Song.NAME, of: Song.self)
    }
    
    // MARK: - 搜索历史
    /// 保存搜索历史
    /// - Parameter data: <#data description#>
    func saveSearchHistory(_ data:SearchHistory) {
        try! database.insertOrReplace(objects: data, intoTable: SearchHistory.NAME)
    }
    
    /// 查询所有搜索历史列表
    func getSearchHistoryAll() ->  [SearchHistory] {
        let results : [SearchHistory]=try! database.getObjects(fromTable: SearchHistory.NAME)
        return results
    }
    
    /// 删除搜索历史
    func deleteSearchHistory(_ data:SearchHistory) {
        try? database.delete(fromTable: SearchHistory.NAME, where: SearchHistory.Properties.title == data.title)
    }
    
    // MARK: - 音乐
    func saveAllSong(_ data:[Song]) {
        //将嵌套模型转为单独的字段
        convertLocal(data)

        try! database.insertOrReplace(objects: data, intoTable: Song.NAME)
    }

    func findPlayList() -> [Song] {
        let results : [Song]=try! database.getObjects(fromTable: Song.NAME,where: Song.Properties.list == true,orderBy: [Song.Properties.createdAt.asOrder(by: .descending)])
        localConvert(results)
        return results
    }

    func find(_ data:String) -> Song? {
        let result: Song? = try! database.getObject(fromTable:Song.NAME,
                                                    where: Song.Properties.id==data)
        result?.localConvert()
        return result
    }

    func saveSong(_ data:Song) {
        data.convertLocal()

        try! database.insertOrReplace(objects: data, intoTable: Song.NAME)
    }
    
    /// 将嵌套模型转为单独的字段
    private func convertLocal(_ data:[Song]) {
        for it in data {
            it.convertLocal()
        }
    }
    
    /// 将单独字段转为嵌套字段
    private func localConvert(_ data:[Song]) {
        for it in data {
            it.localConvert()
        }
    }
}

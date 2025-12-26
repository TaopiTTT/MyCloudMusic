//
//  SearchHistory.swift
//  搜索历史模型
//
//  Created by Tao on 2025/12/26.
//

import UIKit

//腾讯开源的数据库框架
import WCDBSwift

class SearchHistory: BaseModel, TableCodable {
    
    static let NAME = "SearchHistory"
    
    var title:String!

    /// 创建时间
    var createdAt:Int!

    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try! container.decode(String.self, forKey: .title)
        createdAt = try! container.decode(Int.self, forKey: .createdAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try! container.encode(title, forKey: .title)
        try? container.encode(createdAt, forKey: .createdAt)
    }
    
    required init() {
        
    }
    
    //WCDB模型绑定
    enum CodingKeys:String,CodingTableKey {
        typealias Root = SearchHistory
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case title
        case createdAt
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                title: ColumnConstraintBinding(isPrimary: true) //主键
            ]
        }
    }
}

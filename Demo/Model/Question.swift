//
//  Task.swift
//  Demo
//
//  Created by Nhung Nguyen on 16/03/2022.
//

import Foundation
import RealmSwift

class QuestionRealm: Object, ObjectKeyIdentifiable{
    @Persisted var _id: String
    @Persisted var question: String
    @Persisted var createDate: Int64
    @Persisted var lastUpdate: Int64
    @Persisted var userId: String
    @Persisted var index: Int
    @Persisted var options : List<OptionRealm>
}

struct Question:Hashable, Codable {
    var _id : String?
    var question: String
    var createDate: Int64
    var lastUpdate: Int64
    var userId: String
    var index: Int
    var options : [Option]
}


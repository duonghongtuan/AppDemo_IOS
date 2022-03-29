//
//  Task.swift
//  Demo
//
//  Created by Nhung Nguyen on 16/03/2022.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var question: String
    @Persisted var createDate: Double
    @Persisted var lastUpdate: Double
    @Persisted var options : List<Option>
}

//
//  Option.swift
//  Demo
//
//  Created by Nhung Nguyen on 17/03/2022.
//

import Foundation

//struct Option: Identifiable{
//    var id = UUID()
//    var option: String
//    var weight: Int
//}

import RealmSwift

class Option: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var option: String
    @Persisted var weight: Int = 1
}

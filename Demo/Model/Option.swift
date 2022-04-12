//
//  Option.swift
//  Demo
//
//  Created by Nhung Nguyen on 17/03/2022.
//

import Foundation
import RealmSwift

class OptionRealm: Object, ObjectKeyIdentifiable {
    @Persisted var _id: String
    @Persisted var text: String
    @Persisted var weight: Int = 1
}


struct Option:Hashable, Codable{
    var _id: String?
    var text: String
    var weight: Int = 1
}

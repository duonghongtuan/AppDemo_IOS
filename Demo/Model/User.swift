//
//  User.swift
//  Demo
//
//  Created by Nhung Nguyen on 25/03/2022.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted var userId: String
    @Persisted var name: String
    @Persisted var email: String
}

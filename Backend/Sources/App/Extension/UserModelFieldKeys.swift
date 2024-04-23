//
//  UserModelFieldKeys.swift
//
//
//  Created by Chun on 2023/8/30.
//

import Fluent
import Vapor

extension UserModel {
  enum FieldKeys {
    static var account: FieldKey { "account" }
    static var password: FieldKey { "password" }
    static var name: FieldKey { "name" }
    static var playtime: FieldKey { "playtime" }
    static var handedness: FieldKey { "handedness" }
    static var position: FieldKey { "position" }
    static var createdAt: FieldKey { "created_at" }
    static var updatedAt: FieldKey { "updated_at" }
    static var deletedAt: FieldKey { "deleted_at" }
  }
}

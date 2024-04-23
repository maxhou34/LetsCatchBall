//
//  TotalIDModelFieldKeys.swift
//  
//
//  Created by Chun on 2023/8/30.
//

import Fluent
import Vapor

extension TotalIDModel {
  struct FieldKeys {
    static var userID: FieldKey { "user_id" }
    static var activityID: FieldKey { "activity_id" }
    static var createdAt: FieldKey { "created_At" }
    static var updatedAt: FieldKey { "updated_At" }
    static var deletedAt: FieldKey { "deleted_At" }
  }
}

//
//  TotalModelMigration.swift
//  
//
//  Created by Chun on 2023/8/30.
//

import Fluent
import Vapor

struct TotalModelMigration: AsyncMigration {
  
  let schema = TotalIDModel.schema.self
  let keys = TotalIDModel.FieldKeys.self
  
  func prepare(on database: Database) async throws {
    return try await database.schema(schema)
      .id()
      .field(keys.userID, .uuid, .references(UserModel.schema.self, "id"))
      .field(keys.activityID, .uuid, .references(ActivityModel.schema.self, "id"))
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema(schema).delete()
  }
}

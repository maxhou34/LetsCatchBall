//
//  ChatroomModelMigration.swift
//  
//
//  Created by Chun on 2023/8/30.
//

import Fluent
import Vapor

struct ChatroomModelMigration: AsyncMigration {
  
  let schema = ChatroomModel.schema.self
  let keys = ChatroomModel.FieldKeys.self
  
  func prepare(on database: Database) async throws {
    return try await database.schema(schema)
      .id()
      .field(keys.activityID, .uuid, .references(ActivityModel.schema.self, "id"))
      .field(keys.message, .string, .required)
      .field(keys.messageTime, .datetime, .required)
      .field(keys.createdAt, .string, .required)
      .field(keys.deletedAt, .string, .required)
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema(schema).delete()
  }
}

//
//  ActivityModelMigration.swift
//  
//
//  Created by Chun on 2023/8/30.
//

import Fluent
import Vapor

struct ActivityModelMigration: AsyncMigration {
  
  let schema = ActivityModel.schema.self
  let keys = ActivityModel.FieldKeys.self
  
  func prepare(on database: Database) async throws {
    return try await database.schema(schema)
      .id()
      .field(keys.title, .string)
      .field(keys.time, .string)
      .field(keys.location, .string)
      .field(keys.latitude, .double)
      .field(keys.longitude, .double)
      .field(keys.spend, .string)
      .field(keys.information, .string)
      .field(keys.createdAt, .datetime)
      .field(keys.updatedAt, .datetime)
      .field(keys.deletedAt, .datetime)
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema(schema).delete()
  }
}

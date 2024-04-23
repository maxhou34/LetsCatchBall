//
//  UserModelMigration.swift
//  
//
//  Created by Chun on 2023/8/30.
//

import Fluent
import Vapor

struct UserModelMigration: AsyncMigration {
  
  let schema = UserModel.schema.self
  let keys = UserModel.FieldKeys.self
  
  func prepare(on database: Database) async throws {
    return try await database.schema(schema)
      .id()
      .field(keys.account, .string)
      .field(keys.password, .string)
      .field(keys.name, .string)
      .field(keys.playtime, .string)
      .field(keys.handedness, .string)
      .field(keys.position, .string)
      .field(keys.createdAt, .datetime)
      .field(keys.updatedAt, .datetime)
      .field(keys.deletedAt, .datetime)
      .unique(on: keys.account)
      .create()
  }
  
  func revert(on database: Database) async throws {
    try await database.schema(schema).delete()
  }
  
  
  
}

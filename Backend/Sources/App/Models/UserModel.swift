//
//  UserModel.swift
//  
//
//  Created by Chun on 2023/8/28.
//

import Fluent
import Vapor

final class UserModel: Model, Content, Authenticatable {

  static let schema = SchemaEnum.user.rawValue

  @ID(key: .id)
  var id: UUID?
  
  @OptionalField(key: FieldKeys.account)
  var account: String?
  
  @OptionalField(key: FieldKeys.password)
  var password: String?

  @OptionalField(key: FieldKeys.name)
  var name: String?

  @OptionalField(key: FieldKeys.playtime)
  var playtime: String?

  @OptionalField(key: FieldKeys.handedness)
  var handedness: String?
  
  @OptionalField(key: FieldKeys.position)
  var position: String?

  @Timestamp(key: FieldKeys.createdAt, on: .create)
  var createAt: Date?

  @Timestamp(key: FieldKeys.updatedAt, on: .update)
  var updateAt: Date?
  
  @Timestamp(key: FieldKeys.deletedAt, on: .delete)
  var deleteAt: Date?

  init() {}

  init(id: UUID? = nil, account: String? = nil, password: String? = nil, name: String? = nil, playtime: String? = nil, handedness: String? = nil, position: String? = nil, createAt: Date? = nil, updateAt: Date? = nil, deleteAt: Date? = nil) {
    self.id = id
    self.account = account
    self.password = password
    self.name = name
    self.playtime = playtime
    self.handedness = handedness
    self.position = position
    self.createAt = createAt
    self.updateAt = updateAt
    self.deleteAt = deleteAt
  }
}

struct LoginData: Content {
  let account: String
  let password: String
}



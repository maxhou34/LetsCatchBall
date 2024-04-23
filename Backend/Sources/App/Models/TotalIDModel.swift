//
//  TotalIDModel.swift
//  
//
//  Created by Chun on 2023/8/28.
//

import Fluent
import Vapor

final class TotalIDModel: Model, Content {
  
  static let schema = SchemaEnum.totalID.rawValue
  
  @ID(key: .id)
  var id: UUID?
  
  @Parent(key: FieldKeys.userID)
  var user: UserModel
  
  @Parent(key: FieldKeys.activityID)
  var activity: ActivityModel
  
  @Timestamp(key: FieldKeys.createdAt, on: .create)
  var createAt: Date?
  
  @Timestamp(key: FieldKeys.updatedAt, on: .update)
  var updateAt: Date?
  
  @Timestamp(key: FieldKeys.deletedAt, on: .delete)
  var deleteAt: Date?
  
  init() {}
  
  init(id: UUID? = nil , user: UserModel.IDValue, activity: ActivityModel.IDValue, createAt: Date?, updateAt: Date?, deleteAt: Date?) {
    self.id = id
    self.$user.id = user
    self.$activity.id = activity
    self.createAt = createAt
    self.updateAt = updateAt
    self.deleteAt = deleteAt
  }
  
  
}


//
//  ChatroomModel.swift
//  
//
//  Created by Chun on 2023/8/28.
//

import Fluent
import Vapor

final class ChatroomModel: Model, Content {
  
  static let schema = SchemaEnum.chatroom.rawValue
  
  @ID(key: .id)
  var id: UUID?
  
  @Parent(key: FieldKeys.activityID)
  var activity: ActivityModel
  
  @Field(key: FieldKeys.message)
  var message: String
  
  @Field(key: FieldKeys.messageTime)
  var messageTime: Date
  
  @Timestamp(key: FieldKeys.createdAt, on: .create)
  var createAt: Date?
  
  @Timestamp(key: FieldKeys.deletedAt, on: .delete)
  var deleteAt: Date?
  
  init() {}
  
  init(id: UUID? = nil, activity: ActivityModel.IDValue, message: String, messageTime: Date, createAt: Date?, deleteAt: Date?) {
    self.id = id
    self.$activity.id = activity
    self.message = message
    self.messageTime = messageTime
    self.createAt = createAt
    self.deleteAt = deleteAt
  }
}

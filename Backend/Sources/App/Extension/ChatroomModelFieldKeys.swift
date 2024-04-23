//
//  ChatroomModelFieldKeys.swift
//  
//
//  Created by Chun on 2023/8/30.
//

import Fluent
import Vapor

extension ChatroomModel {
  struct FieldKeys {
    static var activityID: FieldKey { "activity_id" }
    static var message: FieldKey { "message" }
    static var messageTime: FieldKey { "messagetime" }
    static var createdAt: FieldKey { "created_at" }
    static var deletedAt: FieldKey { "deleted_At" }
  }
}

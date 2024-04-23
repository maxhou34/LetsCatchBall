//
//  ActivityModelFieldKeys.swift
//
//
//  Created by Chun on 2023/8/30.
//

import Fluent
import Vapor

extension ActivityModel {
  enum FieldKeys {
    static var userID: FieldKey { "user_id" }
    static var title: FieldKey { "title" }
    static var time: FieldKey { "time" }
    static var location: FieldKey { "location" }
    static var latitude: FieldKey { "latitude" }
    static var longitude: FieldKey { "longitude" }
    static var spend: FieldKey { "spend" }
    static var information: FieldKey { "information" }
    static var createdAt: FieldKey { "created_at" }
    static var updatedAt: FieldKey { "updated_at" }
    static var deletedAt: FieldKey { "deleted_at" }
  }
}

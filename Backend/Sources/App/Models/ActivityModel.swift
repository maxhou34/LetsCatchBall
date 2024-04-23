//
//  ActivityModel.swift
//  
//
//  Created by Chun on 2023/8/28.
//

import Fluent
import Vapor

final class ActivityModel: Model, Content {
  
  static let schema = SchemaEnum.activity.rawValue
  
  @ID(key: .id)
  var id: UUID?
  
  @OptionalField(key: FieldKeys.title)
  var title: String?
  
  @OptionalField(key: FieldKeys.time)
  var time: String?
  
  @OptionalField(key: FieldKeys.location)
  var location: String?
  
  @OptionalField(key: FieldKeys.latitude)
  var latitude: Double?
  
  @OptionalField(key: FieldKeys.longitude)
  var longitude: Double?
  
  @OptionalField(key: FieldKeys.spend)
  var spend: String?
  
  @OptionalField(key: FieldKeys.information)
  var information: String?
  
  @Timestamp(key: FieldKeys.createdAt, on: .create)
  var createAt: Date?
  
  @Timestamp(key: FieldKeys.updatedAt, on: .update)
  var updateAt: Date?
  
  @Timestamp(key: FieldKeys.deletedAt, on: .delete)
  var deleteAt: Date?
  
  
  init() {}
  
  init(id: UUID? = nil, title: String? = nil, time: String? = nil, location: String? = nil, latitude: Double? = nil, longitude: Double? = nil, spend: String? = nil, information: String? = nil, createAt: Date? = nil, updateAt: Date? = nil, deleteAt: Date? = nil) {
    self.id = id
    self.title = title
    self.time = time
    self.location = location
    self.latitude = latitude
    self.longitude = longitude
    self.spend = spend
    self.information = information
    self.createAt = createAt
    self.updateAt = updateAt
    self.deleteAt = deleteAt
  }
}


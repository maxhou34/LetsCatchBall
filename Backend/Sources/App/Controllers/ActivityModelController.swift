//
//  ActivityModelController.swift
//
//
//  Created by Chun on 2023/9/30.
//

import Fluent
import Vapor

struct ActivityModelController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let activities = routes.grouped("letscatchball", "activities")

    activities.get("get-all-activity", use: getAllActivity)
    activities.post("create-activity", use: createActivity)
  }

  func getAllActivity(req: Request) async throws -> Response {
    do {
      let activities = try await ActivityModel.query(on: req.db).all()
      let responseData = APIResponse(status: "OK", code: "200", message: "Get Activity Successful", data: activities)
      let response = Response(status: .ok)
      try response.content.encode(responseData)
      return response
    } catch {
      let response = Response(status: .internalServerError)
      let errorResponse = APIResponse(status: "InternalServerError", code: "500", message: error.localizedDescription, data: [] as [ActivityModel]?)
      try response.content.encode(errorResponse)
      return response
    }
  }

  func createActivity(req: Request) async throws -> Response {
    do {
      let activity = try req.content.decode(ActivityModel.self)
      try await activity.save(on: req.db)
      let activityID = activity.id?.uuidString
      let response = Response(status: .created)
      try response.content.encode(["status": "Created", "code": "201", "message": "Activity Created Successful", "activityID": activityID], as: .json)
      return response
    } catch {
      let response = Response(status: .badRequest)
      try response.content.encode(["status": "BadRequest", "code": "400", "message": error.localizedDescription], as: .json)
      return response
    }
  }
}

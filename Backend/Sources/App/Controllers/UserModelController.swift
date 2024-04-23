//
//  UserModelController.swift
//
//
//  Created by Chun on 2023/8/31.
//

import Fluent
import Vapor

struct UserModelController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let users = routes.grouped("letscatchball", "users")
    
    users.get("get-all-user", use: getAllUser)
    users.post("create-user", use: createUser)
    
    users.group(":userID") { user in
      user.get("get-user", use: getUser)
      user.put("update-user", use: updateUser)
      user.delete("delete-user", use: deleteUser)
    }
  }
  
  func getAllUser(req: Request) async throws -> Response {
    do {
      let users = try await UserModel.query(on: req.db).all()
      let responseData = APIResponse(status: "OK", code: "200", message: "Get User Successful", data: users)
      let response = Response(status: .ok)
      try response.content.encode(responseData)
      return response
    } catch {
      let response = Response(status: .internalServerError)
      let errorResponse = APIResponse(status: "InternalServerError", code: "500", message: error.localizedDescription, data: [] as [UserModel]?)
      try response.content.encode(errorResponse)
      return response
    }
  }
  
  func createUser(req: Request) async throws -> Response {
    do {
      let user = try req.content.decode(UserModel.self)
      guard let password = user.password else {
        let response = Response(status: .badRequest)
        try response.content.encode(["status": "BadRequest", "code": "400", "message": "Password Does Not Exist!"], as: .json)
        return response
      }
      let hashedPassword = try await req.password.async.hash(password)
      user.password = hashedPassword
      try await user.save(on: req.db)
      let userID = user.id?.uuidString
      let response = Response(status: .created)
      try response.content.encode(["status": "Created", "code": "201", "message": "User Created Successful", "userID": userID], as: .json)
      return response
    } catch {
      let response = Response(status: .badRequest)
      try response.content.encode(["status": "BadRequest", "code": "400", "message": error.localizedDescription], as: .json)
      return response
    }
  }
  
//  func getUser(req: Request) async throws -> UserModel {
//    let user = try await CheckUserHelper.shard.checkUser(req: req)
//    return user
//  }
  func getUser(req: Request) async throws -> Response {
    do {
      let user = try await CheckUserHelper.shard.checkUser(req: req)
      let responseData = APIResponse(status: "OK", code: "200", message: "Get User Successful", data: [user])
      let response = Response(status: .ok)
      try response.content.encode(responseData)
      return response
    } catch {
      let response = Response(status: .internalServerError)
      let errorResponse: APIResponse<[String: String]> = APIResponse(
          status: "InternalServerError",
          code: "500",
          message: error.localizedDescription,
          data: nil)
      try response.content.encode(errorResponse)
      return response
    }
  }
  
  func updateUser(req: Request) async throws -> Response {
    do {
      let user = try await CheckUserHelper.shard.checkUser(req: req)
      let updateUser = try req.content.decode(UserModel.self)
      if let newPassword = updateUser.password {
        let hashedPassword = try await req.password.async.hash(newPassword)
        user.password = hashedPassword
      }
      user.name = updateUser.name
      user.playtime = updateUser.playtime
      user.handedness = updateUser.handedness
      user.position = updateUser.position
      try await user.update(on: req.db)
      let response = Response(status: .ok)
      try response.content.encode(["status": "OK", "code": "200", "message": "User Updated Successful"], as: .json)
      return response
    } catch {
      let response = Response(status: .badRequest)
      try response.content.encode(["status": "BadRequest", "code": "400", "message": error.localizedDescription], as: .json)
      return response
    }
  }
  
  func deleteUser(req: Request) async throws -> Response {
    let user = try await CheckUserHelper.shard.checkUser(req: req)
    try await user.delete(on: req.db)
    let response = Response(status: .ok)
    try response.content.encode(["status": "OK", "code": "200", "message": "Account Deleted Successful"], as: .json)
    return response
  }
}

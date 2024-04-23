//
//  CheckUserHelper.swift
//  
//
//  Created by Chun on 2023/9/3.
//

import Fluent
import Vapor

final class CheckUserHelper {
  static let shard = CheckUserHelper()
  
  private init() {}
  
  func checkUserID(req: Request) async throws -> UUID {
    guard let userIDParam = req.parameters.get("userID"),
          let useID = UUID(userIDParam) else {
      throw Abort(.badRequest, reason: "Invaild userID Parameter!")
    }
    return useID
  }
  
  func checkUser(req: Request) async throws -> UserModel {
    let userID = try await checkUserID(req: req)
    guard let user = try await UserModel.find(userID, on: req.db) else {
      throw Abort(.notFound, reason: "User Not Found.")
    }
    return user
  }
  
}

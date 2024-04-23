//
//  AuthController.swift
//
//
//  Created by Chun on 2023/9/6.
//

import Fluent
import Vapor

struct AuthController: RouteCollection {
  func boot(routes: Vapor.RoutesBuilder) throws {
    let auth = routes.grouped("letscatchball", "auth")
    auth.post("login", use: login)
  }
  
  func login(req: Request) async throws -> Response {
    let loginData = try req.content.decode(LoginData.self)
    let account = loginData.account
    let password = loginData.password
    guard let user = try await UserModel.query(on: req.db).filter(\.$account == account).first() else {
      let response = Response(status: .unauthorized)
      try response.content.encode(["status": "Unauthorized", "code": "401", "message": "Account Is Wrong!"], as: .json)
      return response
    }
    if let hassedPassword = user.password, try await req.password.async.verify(password, created: hassedPassword) {
      let response = Response(status: .ok)
      let userID = user.id?.uuidString ?? ""
      try response.content.encode(["status": "OK", "code": "200", "message": "Login Successful", "userID": userID], as: .json)
      return response
    } else {
      let response = Response(status: .unauthorized)
      try response.content.encode(["status": "Unauthorized", "code": "401", "message": "Password Is Wrong!"], as: .json)
      return response
    }
  }
}

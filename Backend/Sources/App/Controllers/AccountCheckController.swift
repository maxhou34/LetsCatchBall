//
//  AccountCheckController.swift
//
//
//  Created by Chun on 2023/9/5.
//

import Fluent
import Vapor

struct AccountCheckController: RouteCollection {
  func boot(routes: Vapor.RoutesBuilder) throws {
    let checkAccount = routes.grouped("letscatchball", "check-account")
    checkAccount.post(use: checkAccountExists)
  }

  func checkAccountExists(req: Request) async throws -> Response {
    struct AccountRequest: Content {
      let account: String
    }
    do {
      let accountRequest = try req.content.decode(AccountRequest.self)
      guard !accountRequest.account.isEmpty else {
        let response = Response(status: .badRequest)
        try response.content.encode(["status": "BadRequest", "code": "400", "message": "Account Parameter Is Missing!"], as: .json)
        return response
      }
      if let user = try await UserModel.query(on: req.db).filter(\.$account == accountRequest.account).first() {
        let response = Response(status: .badRequest)
        try response.content.encode(["status": "BadRequest", "code": "400", "message": "This Email Has Been Registered"], as: .json)
        return response
      } else {
        let response = Response(status: .ok)
        try response.content.encode(["status": "OK", "code": "200", "message": "This Email Is Available"], as: .json)
        return response
      }
    } catch {
      let response = Response(status: .badRequest)
      try response.content.encode(["status": "BadRequest", "code": "400", "message": error.localizedDescription], as: .json)
      return response
    }
  }
}

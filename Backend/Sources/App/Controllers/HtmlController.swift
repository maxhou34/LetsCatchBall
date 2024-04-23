//
//  HtmlControlle.swift
//  
//
//  Created by Chun on 2023/10/17.
//

import Vapor

struct HtmlController: RouteCollection {
  func boot(routes: Vapor.RoutesBuilder) throws {
    let privacypolicys = routes.grouped("letscatchball", "privacypolicys")
    
    privacypolicys.get("chinese", use: getChinese)
    privacypolicys.get("english", use: getEnglish)
  }
  
  func getChinese(req: Request) async throws -> View {
    return try await req.view.render("ChinesePrivacyPolicy")
  }
  
  func getEnglish(req: Request) async throws -> View {
    return try await req.view.render("EnglishPrivacyPolicy")
  }
  
  
}

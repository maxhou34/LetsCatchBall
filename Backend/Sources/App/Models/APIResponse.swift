//
//  APIResponse.swift
//  
//
//  Created by Chun on 2023/10/8.
//

import Fluent
import Vapor

struct APIResponse<T: Content>: Content {
    let status: String
    let code: String
    let message: String
    let data: T?
}

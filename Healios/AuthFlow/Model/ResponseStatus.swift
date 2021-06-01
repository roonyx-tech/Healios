//
//  ResponseStatus.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import Foundation

struct ResponseStatus: Codable {
    let status: Int?
    let user: UserData?
}

struct UserData: Codable {
    let id: Int?
    let fullname: String?
    let access_token: String?
}

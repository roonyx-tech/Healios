//
//  AuthTarget.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import Foundation

enum AuthTarget: ApiTarget {
    case login(username: String, password: String)

    var servicePath: String { "" }

    var version: ApiVersion {
        .custom("")
    }

    var path: String {
        switch self {
        case .login:
            return "/v1/auth/sign-in"
        default:
            return ""
        }
    }

    var method: HTTPMethod {
        return .post
    }

    var parameters: [String: Any]? {
        switch self {
        case let .login(username, password):
            return ["username": username.toBase64(), "password": password.toBase64()]
        default:
            return [:]
        }
        
    }

    var stubData: Any {
        return [:]
    }

    var headers: [String: String]? {
        switch self {
        case .login:
            return [:]
        default:
            return [:]
        }
    }
}

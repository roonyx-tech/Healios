//
//  AuthTarget.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import Foundation

enum AuthTarget: ApiTarget {
    case login(username: String, password: String)
    case main
    case resetPassword(phone: String)
    case sms(phone: String)
    case activateSms(phone: String, sms: String)
    case changePassword(phone: String, sms: String, password: String)
    case register(name: String, phone: String, email: String, password: String)

    var servicePath: String { "" }

    var version: ApiVersion {
        .custom("")
    }
    
    var mainUrl: String? {
        switch self {
        case .main:
            return "https://weshop.smartideagroup.kz"
        default:
            return "https://api-weshop.smartideagroup.kz"
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/v1/auth/sign-in"
        case .main:
            return ""
        case .register:
            return "/v1/auth/registration"
        case .resetPassword:
            return "/v1/auth/reset-password-request"
        case .activateSms:
            return "/v1/auth/activation"
        case .sms:
            return "/v1/auth/sms"
        case .changePassword:
            return "/v1/auth/reset-password-sms"
        }
    }

    var method: HTTPMethod {
        return .post
    }

    var parameters: [String: Any]? {
        switch self {
        case let .login(username, password):
            return ["username": username.toBase64(), "password": password.toBase64()]
        case .main:
            return [:]
        case let  .register(name, phone, email, password):
            return ["fullname": name, "password": password, "phone": phone, "email": email]
        case .resetPassword(let phone):
            return ["phone": phone]
        case let .activateSms(phone, sms):
            return ["activationCode": sms, "phone": phone]
        case .sms(let phone):
            return ["phone": phone]
        case let .changePassword(phone, sms, password):
            return ["activationCode": sms, "phone": phone, "password": password]
        }
        
    }

    var stubData: Any {
        return [:]
    }

    var headers: [String: String]? {
        switch self {
        case .login, .register, .resetPassword, .activateSms, .changePassword:
            return [:]
        case .sms:
            return ["appVer": "1.0.0"]
        case .main:
            return [:]
        }
    }
}

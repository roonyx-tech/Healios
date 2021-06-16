//
//  UserSessionStorage.swift
//  WeShop
//
//  Created by kairzhan on 6/16/21.
//

import Foundation
public final class UserSessionStorage {
    @KeychainEntry("accessToken")
    public var accessToken: String?
}

extension UserSessionStorage {
    public func save(accessToken: String?) {
        self.accessToken = accessToken
    }
}

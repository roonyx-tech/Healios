//
//  ResetPasswordModule.swift
//  WeShop
//
//  Created by kairzhan on 6/18/21.
//

import Foundation
protocol ResetPasswordModule: Presentable {
    var saved: Callback? { get set }
}

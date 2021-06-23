//
//  RegisterModule.swift
//  WeShop
//
//  Created by kairzhan on 6/18/21.
//

import Foundation
protocol RegisterModule: Presentable {
    var backTapped: Callback? { get set }
    var registerTapped: Callback? { get set }
}

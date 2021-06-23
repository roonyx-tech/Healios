//
//  AuthModule.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import Foundation
protocol AuthModule: Presentable {
    typealias OpenMain = () -> Void
    var openMain: OpenMain? { get set }
    var backTapped: Callback? { get set }
    var registerTapped: Callback? { get set }
    var resetPasswordTapped: Callback? { get set }
}

//
//  AuthModule.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import Foundation
protocol AuthModule: Presentable {
    typealias OpenMain = (String) -> Void
    var openMain: OpenMain? { get set }
}

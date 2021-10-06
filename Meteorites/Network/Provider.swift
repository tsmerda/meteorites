//
//  Provider.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import Foundation
import Moya

class Provider<T: TargetType> {
    static func buildProvider() -> MoyaProvider<T> {
        let authPlugin = AccessTokenPlugin { _ in CurrentAppManager.shared.appToken}
        return MoyaProvider<T>(plugins: [authPlugin])
    }
}

//
//  MeteoritesTarget.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import Moya

enum MeteoritesTarget: TargetType {
    
    case getMeteorites
    
    var baseURL: URL { URL(string: "https://data.nasa.gov")! }
    
    var path: String {
        switch self {
        case .getMeteorites:
            return "resource/y77d-th95.json"
        }
    }
    
    var method: Method {
        switch self {
        case .getMeteorites:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getMeteorites:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getMeteorites:
            return .requestParameters(parameters: [
                "$where": "year > '2011-01-01T00:00:00'",
                "$order": "mass DESC"
            ], encoding: URLEncoding(destination: .queryString))
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMeteorites:
            return [
                "Content-Type": "application/json",
                "A-App-Token": CurrentAppManager.shared.appToken
            ]
        }
    }
}

//
//  MeteoritesTarget.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import Moya

enum MeteoritesTarget: TargetType {
    
    case getMeteorites
    case loadMoreMeteorites(MeteoriteRequest)
    
    var baseURL: URL { URL(string: "https://data.nasa.gov")! }
    
    var path: String {
        switch self {
        case .getMeteorites, .loadMoreMeteorites:
            return "resource/y77d-th95.json"
        }
    }
    
    var method: Method {
        switch self {
        case .getMeteorites, .loadMoreMeteorites:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getMeteorites, .loadMoreMeteorites:
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
            
        case .loadMoreMeteorites(let request):
            return .requestParameters(parameters: [
                "$where": "year > '2011-01-01T00:00:00'",
                "$limit": request.limit,
                "$offset": request.offset,
                "$order": "mass DESC"
            ], encoding: URLEncoding(destination: .queryString))
        }
    }
    
//    $limit=100&$offset=100
    
    var headers: [String : String]? {
        switch self {
        case .getMeteorites, .loadMoreMeteorites:
            return [
                "Content-Type": "application/json",
                "A-App-Token": CurrentAppManager.shared.appToken
            ]
        }
    }
}

private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data { Data(self.utf8) }
}

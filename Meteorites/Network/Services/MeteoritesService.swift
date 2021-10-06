//
//  MeteoritesService.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import Foundation
import Moya

class MeteoritesService {
    let provider = Provider<MeteoritesTarget>.buildProvider()
    
    func getMeteoriteList(completion: @escaping (Result<[Meteorite], MeteoriteError>) -> Void) {
        provider.request(.getMeteorites) { result in
            switch result {
            case .success(let response):
                do {
                    let preview = try response
                        .filterSuccessfulStatusCodes()
                        .map([Meteorite].self)
                    completion(.success(preview))
                } catch {
                    print("Failed decoding with: \(error.localizedDescription)")
                    completion(.failure(.generic))
                }
            case .failure(let error):
                completion(.failure(.underlying(error)))
            }
        }
    }
    
    func loadMoreMeteorites(limit: Int, completion: @escaping (Result<[Meteorite], MeteoriteError>) -> Void) {
        provider.request(.loadMoreMeteorites(MeteoriteRequest(limit: limit, offset: 0))) { result in
            switch result {
            case .success(let response):
                do {
                    let preview = try response
                        .filterSuccessfulStatusCodes()
                        .map([Meteorite].self)
                    completion(.success(preview))
                } catch {
                    print("Failed decoding with: \(error.localizedDescription)")
                    completion(.failure(.generic))
                }
            case .failure(let error):
                completion(.failure(.underlying(error)))
            }
        }
    }
}

enum MeteoriteError: Error {
    case generic
    case underlying(Error)
    
    var localizedDescription: String {
        switch self {
        case .generic:
            return "Something went wrong."
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}

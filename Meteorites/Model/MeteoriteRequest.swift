//
//  MeteoriteRequest.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 06.10.2021.
//

import Foundation

struct MeteoriteRequest: Encodable {
    let limit: Int
    let offset: Int
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
}

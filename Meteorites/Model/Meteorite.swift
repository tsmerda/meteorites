//
//  Meteorit.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import Foundation

struct Meteorite: Identifiable, Codable, Hashable {
    let name: String
    let id: String
    let nametype: String
    let recclass: String
    let mass: String?
    let fall: String
    let year: String?
    let reclat: String?
    let reclong: String?
    let geolocation: Geolocation?
}

struct Geolocation: Codable, Hashable {
    let type: String?
    let coordinations: [Double]?
}

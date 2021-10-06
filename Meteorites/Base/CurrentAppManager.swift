//
//  CurrentAppManager.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import Foundation

class CurrentAppManager: ObservableObject {
    @Published private(set) var appToken: String = "VrbX54eOckaUfYMonntpi4Iqi"
        
    static let shared = CurrentAppManager()
}

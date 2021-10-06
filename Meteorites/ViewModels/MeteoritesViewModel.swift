//
//  MeteoritesViewModel.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import Foundation

class MeteoritesViewModel: ObservableObject {
    @Published var meteoriteList: [Meteorite]?
    @Published var loadedMeteorites: [Meteorite]?
    private var currentLimit = 10
    
    let service = MeteoritesService()
    
    func fetchMeteoriteList() {
        service.getMeteoriteList { [weak self] result in
            switch result {
            case .success(let response):
                self?.meteoriteList = response
            case .failure(let error):
                print("Failed fetch response with: \(error.localizedDescription)")
            }
        }
    }
    
    func loadMoreMeteorites() {
        service.loadMoreMeteorites(limit: currentLimit) { [weak self] result in
            switch result {
            case .success(let response):
                self?.loadedMeteorites = response
                self?.currentLimit += 10
            case .failure(let error):
                print("Failed fetch response with: \(error.localizedDescription)")
            }
        }
    }
    
    func getRemainingTime(date: String) -> String {
        let dateFormatter = DateFormatter()
        let dateFormatterFinished = DateFormatter()
        let calendar = Calendar.current
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatterFinished.dateFormat = "d. MMMM yyyy"
        
        let formattedDate = dateFormatter.date(from: date)
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formattedDate ?? Date())
        
        let finalDate = calendar.date(from: components) ?? Date()
        
        
        return dateFormatterFinished.string(from: finalDate)
    }
    
    init() {
        fetchMeteoriteList()
        loadMoreMeteorites()
    }
}


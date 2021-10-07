//
//  MeteoritesViewModel.swift
//  Meteorites
//
//  Created by Tomáš Šmerda on 05.10.2021.
//

import Foundation
import Network

class MeteoritesViewModel: ObservableObject {
    @Published var meteoriteList: [Meteorite]?
    static let saveKey = "SavedData"
    static let lastRefreshKey = "LastRefresh"
    private let defaults = UserDefaults.standard
    let calendar = Calendar.current
    let monitor = NWPathMonitor()
    var isInternetConnection = true
    
    let service = MeteoritesService()
    
    func fetchMeteoriteList() {
        service.getMeteoriteList { [weak self] result in
            switch result {
            case .success(let response):
                self?.meteoriteList = response
                self?.save()
            case .failure(let error):
                print("Failed fetch response with: \(error.localizedDescription)")
            }
        }
    }
    
    func getRemainingTime(date: String) -> String {
        let dateFormatter = DateFormatter()
        let dateFormatterFinished = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatterFinished.dateFormat = "d. MMMM yyyy"
        
        let formattedDate = dateFormatter.date(from: date)
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formattedDate ?? Date())
        
        let finalDate = calendar.date(from: components) ?? Date()
        
        return dateFormatterFinished.string(from: finalDate)
    }
    
    func loadDataIfNeeded(completion: (Bool) -> Void) {
        if isRefreshRequired() && isInternetConnection {
            defaults.set(Date(), forKey: Self.lastRefreshKey)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    private func isRefreshRequired() -> Bool {
        guard let lastRefreshDate = defaults.object(forKey: Self.lastRefreshKey) as? Date else {
            return true
        }
        
        
        if let diff = calendar.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, diff > 24 {
            return true
        } else {
            return meteoriteList == nil ? true : false
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(meteoriteList) {
            defaults.set(encoded, forKey: Self.saveKey)
            print("Saved to UserDefaults")
        }
    }
    
    func checkInternetConnection() {
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                self.isInternetConnection = true
            } else {
                print("There's no internet connection.")
                self.isInternetConnection = false
            }
        }
    }
    
    func loadData() {
        loadDataIfNeeded { result in
            switch result {
            case true:
                fetchMeteoriteList()
                return
            case false:
                if let data = defaults.data(forKey: Self.saveKey) {
                    if let decoded = try? JSONDecoder().decode([Meteorite].self, from: data) {
                        print("Load UserDefaults data")
                        self.meteoriteList = decoded
                        return
                    }
                }
            }
        }
    }
    
    init() {
        checkInternetConnection()
        loadData()
    }
}


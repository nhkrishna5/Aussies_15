//
//  AussieViewModel.swift
//  Australia_Cities
//
//  Created by Hari Krishna on 13/02/25.
//

import Foundation

class AussieViewModel: ObservableObject {
    @Published var groupedCities: [String: [AussieModel]] = [:]
    private let cacheKey = "cachedCities"
    
    func loadCities() {
        if let cachedData = UserDefaults.standard.data(forKey: cacheKey),
           let cachedCities = try? JSONDecoder().decode([AussieModel].self, from: cachedData) {
            self.groupedCities = Dictionary(grouping: cachedCities, by: { $0.admin_name })
        } else if let url = Bundle.main.url(forResource: "au_cities", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let cities = try? JSONDecoder().decode([AussieModel].self, from: data) {
            DispatchQueue.main.async {
                self.groupedCities = Dictionary(grouping: cities, by: { $0.admin_name })
                self.cacheCities(cities)
            }
        }
    }
    
    func refreshCities() {
        loadCities()
    }
    
    private func cacheCities(_ cities: [AussieModel]) {
        if let encoded = try? JSONEncoder().encode(cities) {
            UserDefaults.standard.set(encoded, forKey: cacheKey)
        }
    }
}

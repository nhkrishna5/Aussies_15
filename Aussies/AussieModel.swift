//
//  AussieModel.swift
//  Australia_Cities
//
//  Created by Hari Krishna on 13/02/25.
//

import Foundation

struct AussieModel: Codable, Identifiable {
    var id: String { city }
    let city: String
    let admin_name: String
}


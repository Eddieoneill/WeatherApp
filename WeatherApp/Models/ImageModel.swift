//
//  ImageModel.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation

struct ImageObject: Codable & Equatable {
    let imageData: Data
    let date: Date
    let locationName: String
    let identifier = UUID().uuidString
}

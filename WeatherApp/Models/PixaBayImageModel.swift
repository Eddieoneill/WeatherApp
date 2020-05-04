//
//  PixaBayImageModel.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation

import UIKit

struct PixaBayImage: Codable {
    let hits: [Hit]
}

struct Hit: Codable, Equatable {
    let largeImageURL: String
}

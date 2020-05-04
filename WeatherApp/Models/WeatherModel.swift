//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation

struct DarkSkyWeatherData: Codable {
    let currently: Currently?
    let daily: Daily
}

struct Currently: Codable {
    let time: Int
    let summary: String
    let icon: Icon
    let humidity: Double?
}

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
}

struct Daily: Codable {
    let summary, icon: String
    let data: [DailyDatum]
}

struct DailyDatum: Codable {
    let time: Int
    let summary, icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let dewPoint, humidity, pressure, windSpeed: Double
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMax: Double
}


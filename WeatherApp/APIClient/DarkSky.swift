//
//  DarkSky.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation
import NetworkHelper

struct DarkSkyAPI {
    static func getWeatherData(lat: Double, long: Double, completion: @escaping (Result<Daily,AppError>) -> ()) {
        let latLong = "\(lat),\(long)"
        let darkSkyEndpoint = "https://api.darksky.net/forecast/\(SecretKey.darkSkyKey)/\(latLong)"
        guard let url = URL(string: darkSkyEndpoint) else {
            completion(.failure(.badURL(darkSkyEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (results) in
            switch results {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let weatherData):
                do {
                    let results = try JSONDecoder().decode(DarkSkyWeatherData.self, from: weatherData)
                    completion(.success(results.daily))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
}

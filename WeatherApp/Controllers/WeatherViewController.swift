//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import DataPersistence

class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderLabel: UILabel!
}

class WeatherViewController: UIViewController {
    
    public var dataPersistence: DataPersistence<ImageObject>!
    private let mainView = MainView()
    private var lat = Double()
    private var long = Double()
    private var locationName = ""
    
    private var localWeatherData: Daily? {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.textField.delegate = self
        mainView.collectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "weatherCell")
        mainView.collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "sectionLabel")
        getLatLong("11377")
        loadWeatherData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func getLatLong(_ textField: String) {
        ZipCodeHelper.getLatLong(fromZipCode: textField) { (results) in
            switch results {
            case .failure(let fetchingError):
                print("Unable to load location data: \(fetchingError)")
            case .success(let locationData):
                self.lat = locationData.lat
                self.long = locationData.long
                self.locationName = locationData.placeName
            }
        }
    }
    
    private func loadWeatherData() {
        DarkSkyAPI.getWeatherData(lat: self.lat, long: self.long) { (results) in
            switch results {
            case .failure(let appError):
                print("Unable to load weather data: \(appError)")
            case .success(let weatherData):
                self.localWeatherData = weatherData
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionLabel", for: indexPath) as? SectionHeader {
            sectionHeader.sectionHeaderLabel.text = "\(locationName)"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getLatLong(textField.text ?? "11377")
        textField.resignFirstResponder()
        loadWeatherData()
        return true
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 255, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.weatherData = localWeatherData?.data[indexPath.row]
        detailVC.locationName = self.locationName
        detailVC.dataPersistence = dataPersistence
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}



extension WeatherViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localWeatherData?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCell else {
            fatalError("Failed to dequeue collection view cell")
        }
        cell.layer.cornerRadius = 8
        cell.configureCell((localWeatherData?.data[indexPath.row])!)
        return cell
    }
    
    
}

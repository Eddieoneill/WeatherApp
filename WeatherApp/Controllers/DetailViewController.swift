//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence
import AVFoundation

class DetailViewController: UIViewController {
    private let detailView = DetailView()
    
    public var dataPersistence: DataPersistence<ImageObject>!
    private var imageObjects = [ImageObject]()
    private var cityImage: UIImage?
    override func loadView() {
        view = detailView
    }
    public var weatherData: DailyDatum?
    public var locationName: String?
    private var cityPicURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        loadLocationPhotoURL()
        loadWeatherDetails()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action:#selector(saveFavoritePhoto))
    }
    @objc private func saveFavoritePhoto(_ sender: UIBarButtonItem) {
        guard let image = cityImage else {
            print("Image is nil")
            return
        }
        let size = UIScreen.main.bounds.size
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
        guard let resizedImageData = resizedImage.jpegData(compressionQuality: 1.0) else {
            return
        }
        let imageObject = ImageObject(imageData: resizedImageData, date: Date(), locationName: locationName ?? "N/A")
        do {
            try dataPersistence.createItem(imageObject)
            showAlert(title: "Favorite Saved", message: "photo has been saved to favorites")
        } catch {
            print("Error saving photo: \(error)")
        }
    }
    private func loadLocationPhotoURL() {
        PixaBayAPI.getPhotos(searchQuery: locationName ?? "https://pixabay.com/get/52e4d2444a53b108f5d08460962933771738dbe75a4c704c7d2e7bd0914bcd50_1280.jpg") { (results) in
            switch results {
            case .failure(let appError):
                print("failed to load photo: \(appError)")
                
            case .success(let image):
                let cityPic = image.hits.randomElement()
                self.cityPicURL = cityPic?.largeImageURL
                self.loadPhoto()
            }
        }
    }
    private func loadPhoto() {
        DispatchQueue.main.async {
            self.detailView.cityImage.getImage(with: self.cityPicURL ?? "") { [ weak self ] (results) in
                switch results {
                case .failure(let appError):
                    print("failed to load detail: \(appError)")
                    DispatchQueue.main.async {
                        self?.detailView.cityImage.image = UIImage(systemName: "photo")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.detailView.cityImage.image = image
                        self?.cityImage = image
                    }
                }
            }
        }
    }
    private func loadWeatherDetails() {
        let date = NSDate(timeIntervalSince1970: TimeInterval(weatherData!.time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date as Date)
        detailView.dateLabel.text = formattedDate
        
        detailView.tempLowLabel.text = ("Low: \(weatherData?.temperatureLow.description ?? "N/A")")
        detailView.tempHighLabel.text = ("High: \(weatherData?.temperatureHigh.description ?? "N/A")")
        detailView.humidityLabel.text = ("Humidity: \(weatherData?.humidity.description ?? "N/A")")
    }
    
}
extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

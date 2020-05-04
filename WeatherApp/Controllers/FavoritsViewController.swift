//
//  FavoritsViewController.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritsViewController: UIViewController {

     private var favoriteImages = [ImageObject]() {
            didSet {
                favoriteView.favoritesTableView.reloadData()
                print(favoriteImages.count)
            }
        }
        
        private let favoriteView = FavoritesView()
        override func loadView() {
            view = favoriteView
        }
        public var dataPersistence: DataPersistence<ImageObject>!
        override func viewDidAppear(_ animated: Bool) {
            loadFavoriteImages()
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemGray4
            favoriteView.favoritesTableView.delegate = self
            favoriteView.favoritesTableView.dataSource = self
            favoriteView.favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favoriteImageCell")
            loadFavoriteImages()
            
        }
        
        private func loadFavoriteImages() {
            do {
                favoriteImages = try dataPersistence.loadItems()
                print(favoriteImages.count)
            } catch {
                print("Error loading Images: \(error)")
            }
        }
        
    }
    extension FavoritsViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteImages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteImageCell", for: indexPath)
           
            let data = favoriteImages.reversed()[indexPath.row]
            guard let image = UIImage(data: data.imageData) else {
                print("Failed to get image")
                return cell
            }
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.layer.cornerRadius = 8
            cell.imageView?.image = image
            cell.textLabel?.text = data.locationName
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 125
        }
        
    }
    extension FavoritsViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
    }

//
//  DetailView.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var cityImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    public lazy var weatherLabelStack: UIStackView = {
        let labelStack = UIStackView()
        labelStack.axis = .horizontal
        labelStack.alignment = .leading
        return labelStack
    }()
    
    public lazy var tempLowLabel: UILabel = {
        let label = UILabel()
        label.text = "low"
        return label
    }()
    
    public lazy var tempHighLabel: UILabel = {
        let label = UILabel()
        label.text = "high"
        return label
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        return label
    }()
    
    public lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "humidity"
        return label
    }()
    
    public lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(systemName: "heart")
        button.tintColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        constraintsCityImage()
        constraintsDateLabel()
        constraintsTempLowLabel()
        constraintsTempHighLabel()
        constraintsHumidityLabel()
        constraintsFavoriteButton()
    }
    
    private func constraintsCityImage() {
        addSubview(cityImage)
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            cityImage.topAnchor.constraint(equalTo: topAnchor),
            cityImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cityImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cityImage.heightAnchor.constraint(equalTo: cityImage.widthAnchor)
            
        ])
    }
    
    private func constraintsWeatherLabelStack() {
        addSubview(weatherLabelStack)
        weatherLabelStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            weatherLabelStack.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 20),
            weatherLabelStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherLabelStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherLabelStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func constraintsDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            dateLabel.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            
        ])
    }
    
    private func constraintsTempLowLabel() {
        addSubview(tempLowLabel)
        tempLowLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            tempLowLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            tempLowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            
        ])
    }
    
    private func constraintsTempHighLabel() {
        addSubview(tempHighLabel)
        tempHighLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            tempHighLabel.topAnchor.constraint(equalTo: tempLowLabel.bottomAnchor, constant: 8),
            tempHighLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            
        ])
    }
    
    private func constraintsHumidityLabel() {
        addSubview(humidityLabel)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            humidityLabel.topAnchor.constraint(equalTo: tempHighLabel.bottomAnchor, constant: 8),
            humidityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            
        ])
    }
    
    private func constraintsFavoriteButton() {
        addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            favoriteButton.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.20),
            favoriteButton.heightAnchor.constraint(equalTo: widthAnchor)
            
        ])
    }
}

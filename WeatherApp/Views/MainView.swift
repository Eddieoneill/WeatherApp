//
//  MainView.swift
//  WeatherApp
//
//  Created by Edward O'Neill on 5/3/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class MainView: UIView {
    public lazy var sectionHeaderLabel: UICollectionReusableView = {
        let sectionHeader = UICollectionReusableView()
        return sectionHeader
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        
        let cv = UICollectionView(frame: CGRect.zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemGray4
        cv.layer.cornerRadius = 8
        return cv
    }()
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.placeholder = "Enter Zipcode"
        textField.textAlignment = .center
        return textField
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
        setupCollectionViewConstraints()
        setupTextFieldConstraints()
        setupSectionHeaderLabel()
    }
    
    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor)
            
        ])
    }
    
    private func setupTextFieldConstraints() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 80),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            textField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
    
    private func setupSectionHeaderLabel() {
        addSubview(sectionHeaderLabel)
        sectionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionHeaderLabel.topAnchor.constraint(equalTo: collectionView.topAnchor),
            sectionHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
}


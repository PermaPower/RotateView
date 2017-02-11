//
//  PlantDetails.swift
//  RotateScreen
//
//  Created by David on 11/2/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class PlantDetails: UIViewController {
    
    let cellId = "cellID"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    func setupController() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
}

extension PlantDetails: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = .blue
        
        return cell
        
    }
    
}

extension PlantDetails: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
}


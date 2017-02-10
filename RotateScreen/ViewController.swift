//
//  ViewController.swift
//  RotateScreen
//
//  Created by David on 10/2/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        }

    let cellId = "cellID"
    
    let collectionView: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupController()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupController() {
        
        view.addSubview(collectionView)
        
         view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
         view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
}


extension ItemViewController: UICollectionViewDataSource {
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
}

extension ItemViewController: UICollectionViewDelegateFlowLayout {
    
    // Divide the collectionview by 6 x 2
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = 6
        let margings = 2 * (columns - 1)
        let width = (collectionView.frame.size.width - CGFloat(margings)) / CGFloat(columns)
        let height = width // square cells
        return CGSize(width: width, height: height)
    }
    
    // Reduce minimum line spacing between collectionview cells to zero
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let columns = 6
        let totalCellWidth = Float(collectionView.bounds.width) / Float(columns)
        let totalCellHeight = totalCellWidth * 2

        let topInset = (self.view.frame.height - CGFloat(totalCellHeight)) / 2
        let bottInset = (self.view.frame.height - CGFloat(totalCellHeight)) / 2
        
        return UIEdgeInsetsMake(topInset, 0, bottInset, 0)
    }
    
}
    

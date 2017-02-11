//
//  ViewController.swift
//  RotateScreen
//
//  Created by David on 10/2/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    // Upon rotation of device, invalidateLayout
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // Setup cellID for collectionView
    let cellId = "cellID"
    
    // Month names
    let months: [String] = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.allowsMultipleSelection = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        return cv
        
    }()
    
    let calendarIcon: UIImageView = {
        
        let ci = UIImageView()
        ci.image = UIImage(named: "calendar")
        ci.contentMode = .scaleAspectFit
        ci.translatesAutoresizingMaskIntoConstraints = false
        ci.backgroundColor = .white
        ci.clipsToBounds = true
        ci.layer.masksToBounds = true
        ci.layer.cornerRadius = 10
        return ci
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupController()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupController() {
        
        view.addSubview(calendarIcon)
        view.addSubview(collectionView)
        
        view.addConstraintsWithFormat(format: "H:|-10-[v0(50)]-10-[v1]-10-|", views: calendarIcon, collectionView)
       // view.addConstraintsWithFormat(format: "V:|-[v0(50)]", views: calendarIcon)
        view.addConstraintsWithFormat(format: "V:|-[v0]-|", views: collectionView)
        
        
        let widthConstraint = NSLayoutConstraint(item: calendarIcon, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        
        let heightConstraint = NSLayoutConstraint(item: calendarIcon, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        
        let xConstraint = NSLayoutConstraint(item: calendarIcon, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: calendarIcon, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])

        
    }
}


extension ItemViewController: UICollectionViewDataSource {
    
    // Return the number of cells in collecitonView
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    // Modify the cell contents here
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as UICollectionViewCell
        
        let textLabel = UILabel(frame: .zero)
        
        textLabel.textColor = UIColor.white
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.layer.cornerRadius = 10
        textLabel.layer.borderWidth = 1
        textLabel.layer.borderColor = UIColor.white.cgColor
        textLabel.layer.masksToBounds = true
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = months[indexPath.row]
        
        cell.contentView.addSubview(textLabel)
        
        cell.addConstraintsWithFormat(format: "H:|[v0]|", views: textLabel)
        cell.addConstraintsWithFormat(format: "V:|[v0]|", views: textLabel)
        
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
    
    // Insert UIEdge to push collectionview down to center of view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let columns = 6
        let margings = 2 * (columns - 1)
        let totalCellwidth = (collectionView.frame.size.width - CGFloat(margings)) / CGFloat(columns)
        let totalCellHeight = totalCellwidth * 2 + 5
        
        let topInset = (self.view.frame.size.height - CGFloat(totalCellHeight)) / 2
        let bottInset = (self.view.frame.size.height - CGFloat(totalCellHeight)) / 2
        
        return UIEdgeInsetsMake(topInset, 0, bottInset, 0)
    }
    
    // Detetect if UICollectionViewCell was selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .red
        print("Selected: \(indexPath.row)" )
    }
    
    // Detetect if UICollectionViewCell was deselected
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .clear
        print("DeSelected: \(indexPath.row)" )
    }
    
}

//
//  BottomCollectionView.swift
//  gridy
//
//  Created by ollie on 12/20/19.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import UIKit

class BottomCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public var correctImages: [UIImage]!
    public var images: [UIImage]!
    static private let kID = "largeCell"   // Change to your identifier on the storyboard
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        delegate = self
        dataSource = self
        dropDelegate = self
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionView.kID, for: indexPath)
        
        // Configure Cell Here
        
        return cell
    }
}

extension BottomCollectionView: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        // Configure drop here
        // Handle score here
        
    }
}

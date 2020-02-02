//
//  BottomCollectionView.swift
//  gridy
//
//  Created by ollie on 12/20/19.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import UIKit

class BottomCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
     
    @IBOutlet weak var largeCellEmptyImage: UIImageView!
    
    public var correctImages: [UIImage]!
    fileprivate var imageArray: [String] = ["dummyCell1","dummyCell2","dummyCell3","dummyCell4","dummyCell5","dummyCell6","dummyCell7","dummyCell8","dummyCell9","dummyCell10","dummyCell11" ,"dummyCell12"]
    
    private var gridLocations = [CGPoint]()
    static private let kID = "largeCell"   // Change to your identifier on the storyboard
 
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        delegate = self
        dataSource = self
        dropDelegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionView.kID, for: indexPath)
//            as! GridyCell
        cell.backgroundColor = .white
        print(indexPath)
        let image = UIImage(named: self.imageArray[indexPath.row])
      let cellImage = UIImageView(image: image)
     cell.contentView.addSubview(cellImage)
        return cell
       }
    }


extension BottomCollectionView: UICollectionViewDropDelegate {
   
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
     
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        coordinator.session.loadObjects(ofClass: (UIImage.self), completion: { (images) in
            for photo in images {
                self.correctImages.insert(photo as! UIImage, at: destinationIndexPath.item)
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: [destinationIndexPath])
                })
            }
        })
    }
}
    
//
//    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
//        guard (coordinator.destinationIndexPath) != nil else { return }
//        guard coordinator.items.first != nil else { return}
//     }
//  }

      
 
    /// Check if image at drop
        /// If it is, you are going to drop it in at index.row
        

    
    
   
    
    

    
    
    
    
    
    
    
    
   
    
    
    
    


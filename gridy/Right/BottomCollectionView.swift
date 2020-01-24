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
    public var images: [UIImage]! = [UIImage] ()
    static private let kID = "largeCell"   // Change to your identifier on the storyboard
    
    
         
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionView.kID, for: indexPath) as! GridyCell
          cell.imageView.image = images[indexPath.item]
        return cell
    }
}

extension BottomCollectionView: UICollectionViewDropDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
 print ("correctImages [index.row]")
        guard let index = coordinator.destinationIndexPath else { return }
        guard let dropItem = coordinator.items.first else { return
            
    
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let item = images[indexPath.item]
        let itemProvider = NSItemProvider(object: item as UIImage)
        let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.localObject = item
        return [dragItem]
        }
        
 
    func addItem(_ newItem: UIImage, at index: Int) {
        images.insert(newItem, at: index)
        }
        
    func deleteItem(at sourceIndex: Int) {
        images.remove(at: sourceIndex)
        }
        
    func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        let item = images[sourceIndex]
           images.insert(item, at: destinationIndex)
            images.remove(at: sourceIndex)
        }
        
    func swapItem(at sourceIndex: Int, to destinationIndex: Int) {
            guard sourceIndex != destinationIndex else { return }
        images.swapAt(sourceIndex, destinationIndex)
        }
        
    func getItemAtIndex(indexPath: Int) -> UIImage? {
        return images[indexPath]
        }
      }
  }
}
            
        /// Check if image at drop == correctimages[index.row]
        /// If it is, you are going to drop it in at index.row
        

    
    

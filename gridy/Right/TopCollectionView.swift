//
//  TopCollectionView.swift
//  gridy
//
//  Created by ollie on 12/20/19.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import UIKit

class TopCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public var images: [UIImage] = []
    static private let kID = "Cell"   // Change to your identifier on the storyboard
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        delegate = self
        dataSource = self
        dragDelegate = self
//        dropDelegate = self
        dragInteractionEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! GridyCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
            
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Starting Index: \(sourceIndexPath.item)")
        print("Ending Index: \(destinationIndexPath.item)")
    }
    
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath  {
                
        collectionView.performBatchUpdates({
            images.remove(at: sourceIndexPath.item)
            images.insert(item.dragItem.localObject as! UIImage, at: destinationIndexPath.item)
            
        collectionView.deleteItems(at: [sourceIndexPath])
            collectionView.insertItems(at: [destinationIndexPath ] )
            }, completion: nil)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath )
        }
     }
}
 
extension TopCollectionView: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at IndexPath: IndexPath) -> [UIDragItem] {
        let item = self.images[IndexPath.row]
        let itemProvider = NSItemProvider(object: item as UIImage)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}


    
    
    
    
    
    
//
//   func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
//        if collectionView.hasActiveDrag {
//        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//
//        }
//       return UICollectionViewDropProposal(operation: .forbidden)
//        }
//
//    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
//
//        let destinationIndexPath: IndexPath
//        if let indexPath = coordinator.destinationIndexPath{
//                   destinationIndexPath = indexPath
//            }
//        else{
//            destinationIndexPath = IndexPath(row: 0, section: 0)
//            }
//        collectionView.moveItem(at: (coordinator.items.first?.sourceIndexPath)!, to: destinationIndexPath)
//                    }
//                }

      

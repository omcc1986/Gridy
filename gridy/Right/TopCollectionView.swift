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
        dropDelegate = self
        dragInteractionEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        return cell
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
        }
            
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
                print("Starting Index: \(sourceIndexPath.item)")
                print("Ending Index: \(destinationIndexPath.item)")
            }
        
        return cell
    }
  
    fileprivate func reorderItems(coordinator: UICollectionViewDropDelegate, destinationIndexPath: IndexPath, collectionView: UICollectionView){
        if let item = coordinator.item.first,
            let sourceIndexPath = item.sourceIndexPath  {
                
                collectionView.performBatchUpdates({
                    self.items.remove(at: sourceIndexPath.item)
                    self.items.insert(item.dragItem.localObject as! String, at: destinationIndexPath.item)
            
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath ] )
            }, completion: nil)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath )
        }
     }
  }
 
extension TopCollectionView: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at IndexPath: IndexPath) -> [UIDragItem] {
        let item = self.items[IndexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension TopCollectionView: UICollectionViewDropDelegate {
   func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
         if collectionView.hasActiveDrag {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            
        }
       return UICollectionViewDropProposal(operation: .forbidden)
        }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath
        
        guard let indexPath = destinationIndexPath else {return }
        
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexPath: indexPath, collectionView: collectionView)
        }
    }
}
    
    
      

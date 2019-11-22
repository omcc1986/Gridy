//
//  ViewController3.swift
//  gridy
//
//  Created by ollie on 23/09/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import Foundation
import UIKit

class GridyCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var Cell: UIView!
}

class ViewController3: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate, UIDropInteractionDelegate, UICollectionViewDragDelegate {
    
    //variables
    var toReceive = [UIImage]() // keep correct order for comparison
    var collectionOne = [UIImage]() // image split into pieces, will reorder
    var collectionTwo = [UIImage]() // holds placeholders in drop spaces
    var collectionViewIndexPath: IndexPath?
    var rightMoves: Int = 0
 
    //outlets
    @IBOutlet weak var movesCount: UILabel!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOne = toReceive
        collectionOne.shuffle()
        print(":: DEBUGGING CODE :: \(toReceive.count)")

    // setting collection view delegates & data sources
   firstCollectionView.dataSource = self
   firstCollectionView.dragDelegate = self
   gameCollectionView.dragDelegate = self
//   gameCollectionView.dropDelegate = ?
//   firstCollectionView.dropDelegate = ?
//   gameCollectionView.dataSource = ?
        
    // not allowing collection views to scroll
    firstCollectionView.isScrollEnabled = false
    gameCollectionView.isScrollEnabled = false
   
        gameCollectionView.reloadData()

//     enabling drag on collection views
    firstCollectionView.dragInteractionEnabled = true
    gameCollectionView.dragInteractionEnabled = true
}

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self .collectionOne.count
}

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = firstCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GridyCell
    cell.imageView.image = collectionOne[indexPath.item]
    return cell
    }

 
func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let item = collectionView == firstCollectionView ?
    toReceive[indexPath.row] : collectionTwo[indexPath.row]
    let itemProvider = NSItemProvider(object: item as UIImage)
    let dragItem = UIDragItem(itemProvider: itemProvider)
    dragItem.localObject = item
    return [dragItem]
        
    }
    
    // Drop Session
        func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
            if destinationIndexPath?.row == 16 || destinationIndexPath?.row == 17 {
                return UICollectionViewDropProposal(operation: .forbidden)
            } else if collectionView === firstCollectionView  {
                return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
            } else if collectionView === gameCollectionView && gameCollectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
            } else {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
            let dip: IndexPath
            if let indexPath = coordinator.destinationIndexPath {
                dip = indexPath
            } else {
                let section = collectionView.numberOfSections - 1
                let row = collectionView.numberOfItems(inSection: section)
                dip = IndexPath(row: row, section: section)
            }
            if dip.row == 16 || dip.row == 17 {
                return
            }
            if collectionView === gameCollectionView {
                moveItems(coordinator: coordinator, destinationIndexPath: dip, collectionView: collectionView)
            } else if collectionView === firstCollectionView {
                reorderItems(coordinator: coordinator, destinationIndexPath: dip, collectionView: collectionView)
            } else {
                return
            }
        }
        
        // drag and drop functions
        private func moveItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
            let items = coordinator.items
            collectionView.performBatchUpdates({
                let dragItem = items.first!.dragItem.localObject as! UIImage
                if dragItem === toReceive[destinationIndexPath.item] {
                self.collectionTwo.insert(items.first!.dragItem.localObject as! UIImage, at: destinationIndexPath.row)
                    gameCollectionView.insertItems(at: [destinationIndexPath])
                    if let selected = collectionViewIndexPath {
                        collectionOne.remove(at: selected.row)
                        if let temp = UIImage(named: "Blank") {
                            let blank = temp
                            collectionOne.insert(blank, at: selected.row)
                        }
                        firstCollectionView.reloadData()
                    }
                
                    }
                })
            
            collectionView.performBatchUpdates({
                if items.first!.dragItem.localObject as! UIImage === toReceive[destinationIndexPath.item] {
                    self.collectionTwo.remove(at: destinationIndexPath.row + 1)
                    let nextIndexPath = NSIndexPath(row: destinationIndexPath.row + 1, section: 0)
                    gameCollectionView.deleteItems(at: [nextIndexPath] as [IndexPath])
                }
            })
            coordinator.drop(items.first!.dragItem, toItemAt: destinationIndexPath)
            if rightMoves == collectionTwo.count {
                print ("gameover screen")
            }
        }
        
        func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
            let items = coordinator.items
            if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath {
                var dIndexPath = destinationIndexPath
                if dIndexPath.row >= collectionView.numberOfItems(inSection: 0)
                {
                    dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
                }
                collectionView.performBatchUpdates({
                    self.collectionOne.remove(at: sourceIndexPath.row)
                    self.collectionOne.insert(item.dragItem.localObject as! UIImage, at: dIndexPath.row)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [dIndexPath])
                })
                coordinator.drop(item.dragItem, toItemAt: dIndexPath)
            }
        
        }
    }
    


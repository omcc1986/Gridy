//
//  gameCollectionView.swift
//  gridy
//
//  Created by ollie on 03/12/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import UIKit

class gameCollectionView: UICollectionView {
    
        private var images: [UIImage] = []
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.delegate = self
            self.dataSource = self
            self.dropDelegate = self
        }
    }

extension gameCollectionView: UICollectionViewDataSource  {
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
}
        
extension gameCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let largeCell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: "largeCell", for: indexPath) as! GridyCell
            largeCell.imageView.image = images[indexPath.item]
//
            return UICollectionViewCell()
              }
            }
            
        
 
extension gameCollectionView: UICollectionViewDropDelegate {
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
    

   

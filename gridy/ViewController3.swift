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
    UICollectionViewDelegate,
    UIDropInteractionDelegate,
    UICollectionViewDragDelegate {
    
   
    var collectionViewIndexPath: IndexPath?
    var moves = 0

    var toReceive = [UIImage]()
    var collectionOne = [UIImage]()
    var collectionTwo = [UIImage]()

    // arrays of tiles from split image
    var originalTiles = [UIImage]() // image split into pieces, will reorder
    var originalTilesBeforeShuffle = [UIImage]() // keep correct order for comparison
    var targetTiles = [UIImage]() // holds placeholders in drop spaces
    
    //    @IBOutlet weak var hintImage: UIImageView!
    //    @IBOutlet weak var hintView: UIView!
    @IBOutlet weak var movesCount: UILabel!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    

    
    
    //    @IBAction func showHint(_ sender: Any) {
    //        // shows hint for 2 seconds and updates move count
    //        hintImage.image = editedImage
    //        hintView.isHidden = false
    //        perform(#selector(hideHintView), with: nil, afterDelay: 2)
    //        moves += 1
    //        movesCount.text = String(moves)
    //    }
    
    
    public var editedImage: UIImage? // for screenshot from last view (screenshot in A)
    let gridSize = 4


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOne = toReceive
        collectionOne.shuffle()
        print(":: DEBUGGING CODE :: \(toReceive.count)")
//    }
    
    // setting collection view delegates & data sources
    firstCollectionView.dataSource = self
//    gameCollectionView.dataSource = self
    firstCollectionView.dragDelegate = self
//    firstCollectionView.dropDelegate = self
    gameCollectionView.dragDelegate = self
//    gameCollectionView.dropDelegate = self

    // not allowing collection views to scroll
    firstCollectionView.isScrollEnabled = false
    gameCollectionView.isScrollEnabled = false

//    // fill tile arrays
//    if let editedImage = editedImage {
////        let tiles = editedImage.slice (into: 4)
//        originalTilesBeforeShuffle = tiles
//        originalTiles.removeAll()
//        originalTiles = tiles
//        originalTiles.shuffle()
//        firstCollectionView.reloadData()

//        for _ in 1...16 {
//            targetTiles.append(UIImage(named: "placeholder")!)
//        }

        gameCollectionView.reloadData()
//    }

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
    let item = collectionView == firstCollectionView ? originalTiles[indexPath.row] : targetTiles[indexPath.row]
    let itemProvider = NSItemProvider(object: item as UIImage)
    let dragItem = UIDragItem(itemProvider: itemProvider)
    dragItem.localObject = item
    return [dragItem]
        
    }
      // moving tiles between collection views adn updating contents
         private func moveItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
             let items = coordinator.items
             
            collectionView.performBatchUpdates({
                 let dragItem = items.first!.dragItem.localObject as! UIImage
                 if dragItem === originalTilesBeforeShuffle[destinationIndexPath.item] {
                     self.targetTiles.insert(items.first!.dragItem.localObject as! UIImage, at: destinationIndexPath.row)
                     gameCollectionView.insertItems(at: [destinationIndexPath])
                     
                     if let selected = collectionViewIndexPath {
                         originalTiles.remove(at: selected.row)
                         if let temp = UIImage(named: "placeholder") {
                             let blank = temp
                             originalTiles.insert(blank, at: selected.row)
                         }
                         firstCollectionView.reloadData()
                         
                     }
                     
                 }
             })
             
             collectionView.performBatchUpdates({
                 if items.first!.dragItem.localObject as! UIImage === originalTilesBeforeShuffle[destinationIndexPath.item] {
                     targetTiles.remove(at: destinationIndexPath.row + 1)
                     let nextIndexPath = NSIndexPath(row: destinationIndexPath.row + 1, section: 0)
                     gameCollectionView.deleteItems(at: [nextIndexPath] as [IndexPath])
                     gameCollectionView.reloadData()
                 }
             })
             
           
          
       
       
    }
    
    }

 





//    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
//        <#code#>
//}
//
//// moving tiles between collection views adn updating contents
//  private func moveItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
//      let items = coordinator.items
//
//      collectionView.performBatchUpdates({
//          let dragItem = items.first!.dragItem.localObject as! UIImage
//          if dragItem === originalTilesBeforeShuffle[destinationIndexPath.item] {
//              self.targetTiles.insert(items.first!.dragItem.localObject as! UIImage, at: destinationIndexPath.row)
//              targetCollectionView.insertItems(at: [destinationIndexPath])
//
//              if let selected = collectionViewIndexPath {
//                  originalTiles.remove(at: selected.row)
//                  if let temp = UIImage(named: "placeholder") {
//                      let blank = temp
//                      originalTiles.insert(blank, at: selected.row)
//                  }
//                  tileCollectionView.reloadData()
//
//              }
//
//          }
//      })
//
//      collectionView.performBatchUpdates({
//          if items.first!.dragItem.localObject as! UIImage === originalTilesBeforeShuffle[destinationIndexPath.item] {
//              targetTiles.remove(at: destinationIndexPath.row + 1)
//              let nextIndexPath = NSIndexPath(row: destinationIndexPath.row + 1, section: 0)
//              targetCollectionView.deleteItems(at: [nextIndexPath] as [IndexPath])
//              targetCollectionView.reloadData()
//          }
//      })
//
//      coordinator.drop(items.first!.dragItem, toItemAt: destinationIndexPath)
//
//      // adding to move count and updating label
//      moves += 1
//      movesCount.text = String(moves)
//
//      // testing for win after each move
//      if originalTiles.allSatisfy({$0 == UIImage(named: "placeholder")}) {
//          print("You win!")
//          performSegue(withIdentifier: "PuzzletoWinSegue", sender: nil)
//      }
//
//  }
//
//  @objc func hideHintView() {
//      hintView.isHidden = true
//  }
//
//
//
//
    

    


    
//    -------------
    
    //MARK: - IBOutlets
//      @IBOutlet weak var tileView: UICollectionView!
//      @IBOutlet weak var puzzleBoard: UICollectionView!
//      @IBOutlet weak var scoreLabel: UILabel!
//      @IBOutlet weak var popUpView: UIImageView!
//      @IBOutlet weak var newGameButton: UIButton!
//      @IBAction func switchButtonOn(_ sender: UISwitch) {
//      }
//
//      //MARK: - Variables
//      var toReceive = [UIImage]()
//      var tileViewImages :[UIImage]!
//      var puzzleBoardImages = [UIImage]()
//      var fixedImages = [UIImage(named: "Blank"), UIImage(named: "Gridy-lookup")]
//      var moves: Int = 0
//      var rightMoves: Int = 0
//      var popUpImage = UIImage()
//      var isSelected: IndexPath?
//      var audioPlayer: AVAudioPlayer?
//
//      //MARK: - View Functions
//      override func viewDidLoad() {
//          super.viewDidLoad()
//
//          tileViewImages = toReceive
//          tileViewImages.shuffle()
//          tileView.reloadData()
//          popUpView.image = popUpImage
//          popUpView.isHidden = true
//          scoring(moves: moves)
//          for image in fixedImages {
//              if let image = image {
//                  tileViewImages.append(image)
//              }
//          }
//          tileView.dragInteractionEnabled = true
//          puzzleBoard.dragInteractionEnabled = true
//          if puzzleBoardImages.count == 0 {
//              if let blank = UIImage(named: "Blank") {
//                  var temp = [UIImage]()
//                  for _ in toReceive {
//                      temp.append(blank)
//                  }
//                  puzzleBoardImages = temp
//                  puzzleBoard.reloadData()
//              }
//          }
//      }
//
//      override func didReceiveMemoryWarning() {
//          super.didReceiveMemoryWarning()
//      }
//
//
//-----------------
    
 
  





   
    
 


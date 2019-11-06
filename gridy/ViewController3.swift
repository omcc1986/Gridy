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
}

class ViewController3: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var toReceive = [UIImage]()
    var collectionOne = [UIImage]()
    var collectionTwo = [UIImage]()
    
    @IBOutlet weak var collectionView: UICollectionView!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOne = toReceive
        collectionOne.shuffle()
        print(":: DEBUGGING CODE :: \(toReceive.count)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return self.collectionOne.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridyCell
        cell1.imageView.image = collectionOne[indexPath.item]
        return cell1
    }
    

}
  





   
    
 


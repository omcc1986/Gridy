//
//  ViewController3.swift
//  gridy
//
//  Created by ollie on 23/09/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import Foundation
import UIKit

class cell: UICollectionViewCell {
    

}

class ViewController3: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var toReceive = [UIImage]()
    var collectionOne = [UIImage]()
    var collectionTwo = [UIImage]()
    static var identifier: String = "cell"
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return self.toReceive.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cell
        return cell1
    }
    
    
    @IBAction func newGame(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "toReceive", bundle: nil), forCellWithReuseIdentifier: "toReceive")
        toReceive.shuffle()
        collectionOne = toReceive
        print(":: DEBUGGING CODE :: \(toReceive.count)")
    }
}
  





   
    
 


//
//  ViewController3.swift
//  gridy
//
//  Created by ollie on 23/09/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import Foundation
import UIKit

class ViewController3: UIViewController {

    var toReceive = [UIImage]()
    var collectionOne = [UIImage]()
    var collectionTwo = [UIImage]()


    
    override func viewDidLoad() {
        toReceive.shuffle()
        collectionOne = toReceive
        
    }
 
    
    
@IBOutlet weak var gameScreen: UIImageView!
    
  
}

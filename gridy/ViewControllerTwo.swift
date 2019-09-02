//
//  ViewControllerTwo.swift
//  gridy
//
//  Created by ollie on 21/08/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerTwo: UIViewController {
    
    // Our received data
    var receivedImage = UIImage()
    var username: String = "Anonymous"
    
    // UIImage
    @IBOutlet weak var selectedImage: UIImageView!
   
    // Standard viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = receivedImage
      }
}



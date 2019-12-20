//
//  pictureUploadEdit.swift
//  gridy
//
//  Created by ollie on 26/07/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import Foundation
import UIKit

class PictureUploadEdit {
    var image: UIImage
    
    
    
    static var defaultImage: UIImage {
        return UIImage.init(named:"Gridy-name-large-green")!
    }
    
    init() {
        // stored property
        image = PictureUploadEdit.defaultImage
    }
    
}


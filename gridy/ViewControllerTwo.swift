//
//  ViewControllerTwo.swift
//  gridy
//
//  Created by ollie on 21/08/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerTwo: UIViewController, UIGestureRecognizerDelegate {
    
    // Our received data
    var receivedImage = UIImage()
    
    // UIImage
    @IBOutlet weak var selectedImage: UIImageView!
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        
       let translation = recognizer.translation(in: view)
        recognizerView.center.x += translation.x
        recognizerView.center.y += translation.y
        recognizer.setTranslation( .zero, in: view)
    }

    @IBAction func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
    selectedImage.transform = selectedImage.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }

    @IBAction func handleRotation(_ recognizer: UIRotationGestureRecognizer) {
    selectedImage.transform = selectedImage.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
    }

    internal func gestureRecognizer(_  gestureReconizer: UIGestureRecognizer,
                                shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
    -> Bool {
        //condition for simultanious gesture
        if gestureReconizer.view != selectedImage{
            return false
        }
        if gestureReconizer is UIRotationGestureRecognizer
            || otherGestureRecognizer is UIPinchGestureRecognizer
            || gestureReconizer is UIPanGestureRecognizer
            || otherGestureRecognizer is UIPanGestureRecognizer{
            return false
        }
        
        return true
}

    // Standard viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = receivedImage
      }

}

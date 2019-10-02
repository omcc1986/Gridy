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
   
    
    var toSend = [UIImage]()
    
    
    // UIImage
    @IBOutlet weak var selectedImage: UIImageView!
    
    
    // Standard viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = receivedImage
    }
    
    
//    @IBAction func startButton
    
    
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

    internal func gestureRecognizer(_  gestureReconizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let pickedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided with the following: \(info)")
        }
        receivedImage = pickedImage
        processPicked(image: receivedImage)
    }
 // selectedImage
    func processPicked(image: UIImage?) {
        if image != nil {
            performSegue(withIdentifier: "segueTwo", sender: self)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
      }

    func slice(image: UIImage, into howMany: Int) -> [UIImage] {
        let width: CGFloat
        let height: CGFloat
        
        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            width = image.size.height
            height = image.size.width
        default:
            width = image.size.width
            height = image.size.height
        }
        
        let tileWidth = Int(width / CGFloat(howMany))
        let tileHeight = Int(height / CGFloat(howMany))
        
        let scale = Int(image.scale)
        var images = [UIImage]()
        let cgImage = image.cgImage!
        
        var adjustedHeight = tileHeight
        
        var y = 0
        for row in 0 ..< howMany {
            if row == (howMany - 1) {
                adjustedHeight = Int(height) - y
            }
            var adjustedWidth = tileWidth
            var x = 0
            for column in 0 ..< howMany {
                if column == (howMany - 1) {
                    adjustedWidth = Int(width) - x
                }
                let origin = CGPoint(x: x * scale, y: y * scale)
                let size = CGSize(width: adjustedWidth * scale, height: adjustedHeight * scale)
                let tileCGImage = cgImage.cropping(to: CGRect(origin: origin, size: size))!
                images.append(UIImage(cgImage: tileCGImage, scale: image.scale, orientation: image.imageOrientation))
                x += tileWidth
            }
            y += tileHeight
        }
        return images
    }


   
    func toPass() {
    if let image = UIImage(named: "sample.jpg") {
        DispatchQueue.global(qos: .userInitiated).async {
            // get cropped image
            self.toSend = self.slice(image: image, into: 6 * 6)
        }
    }
    
    else {
        print ("Image not found")
    }

  }
    @IBAction func startButton(_ sender: Any) {
      
      
      performSegue(withIdentifier: "segueTwo", sender: self)
          selectedImage.transform = .identity
      }
    
    
    // Send cropped images to third view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Replace "someID" with your storeboard segue ID
        if segue.identifier == "segueTwo" {
            // Replace "ThirdViewController" with your second controller class name
            let vc = segue.destination as! ViewController3
            vc.toReceive = toSend
        }
    }



}
//


//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        if let image = newImage {
//            toReceive = image
//        }
//        picker.dismiss(animated: true) {
//            self.performSegue(withIdentifier: "segueTwo", sender: self)
//        }
//    }
//
//
//
//    override func prepare(for segueTwo: UIStoryboardSegue, sender: Any?) {
//        if segueTwo.identifier == "segueTwo" {
//            let vc = segueTwo.destination as! ViewController3
//            vc.toReceive = gameScreen
//        }
//    }



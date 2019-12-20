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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var container: UIImageView!
    
    
    // Standard viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = receivedImage
        backgroundImage.image = receivedImage
    }
    
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

    internal func gestureRecognizer(_  gestureReconizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
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

    
    func slice(screenshot: UIImage, into howMany: Int) -> [UIImage] {
        let width: CGFloat
        let height: CGFloat

        switch screenshot.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            width = screenshot.size.height
            height = screenshot.size.width
        default:
            width = screenshot.size.width
            height = screenshot.size.height
        }

        let tileWidth = Int(width / CGFloat(howMany))
        let tileHeight = Int(height / CGFloat(howMany))

        let scale = Int(screenshot.scale)
        var images = [UIImage]()
        let cgImage = screenshot.cgImage!

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
                images.append(UIImage(cgImage: tileCGImage, scale: screenshot.scale, orientation: screenshot.imageOrientation))
                x += tileWidth
            }
            y += tileHeight
        }
        return images
    }
   
   
    
    @IBAction func backButton(_  sender: Any) {
   dismiss(animated: true, completion: nil)
    }
    
    func toPass(completion: @escaping () -> Void) {
        if let image = selectedImage.image {
            NSLog(image.debugDescription)
            DispatchQueue.global(qos: .userInitiated).async {
                // get cropped image
                self.toSend = self.slice(screenshot:image, into: 4)
                completion()
            }
        } else {
            print ("Image not found")
        }
    }
    
    func drawing() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: selectedImage.frame.width, height: selectedImage.frame.height))
       
//    Warning not used
//        let gridDrawer = receivedImage
        let image = renderer.image { (ctx) in
            if view.frame.width < view.frame.height {
        let squareDimension = view.frame.width * 0.9
            selectedImage.frame = CGRect(x: (view.frame.width - squareDimension)/2, y: (view.frame.height - squareDimension)/2, width: squareDimension, height: squareDimension)

//           ERROR
                
//           container.selectedImage(context: ctx, squareDimension: squareDimension - 1)

        } else {
            // landscape orientation
        let squareDimension = view.frame.height*0.9
                container.frame = CGRect(x: (view.frame.width - squareDimension)/2, y: (view.frame.height - squareDimension)/2, width: squareDimension, height: squareDimension)
                // passing squareDimension - 1 to protect grid lines from being clipped at the edges
//                gridDrawer.toSend(context: ctx, squareDimension: squareDimension - 1)
            }
        }
        // populate the gridView view with the rendered image
        selectedImage.image = image
    }
//     ERROR within the Crop
    
//    // Function to take a screenshot the size of cropImageBoxView
//    func cropImage() -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(container.bounds.size, false, 0)selectedImage.drawHierarchy(in: selectedImage.bounds, afterScreenUpdates: true)
//        let screenShot = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return screenShot
//    }

 
    func configure() {
        drawing()
        container.image = receivedImage
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        toPass {
            DispatchQueue.main.async {
                self.selectedImage.transform = .identity
                self.performSegue(withIdentifier: "segueTwo", sender: self)
            }
        }
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


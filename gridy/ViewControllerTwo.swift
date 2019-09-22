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
    var imageForGridy = UIImage()
    var outGoingVC3 = UIImage()
    var userChosenImage = UIImage()
    
    // UIImage
    @IBOutlet weak var selectedImage: UIImageView!
    
    
    // Standard viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = receivedImage
    }
    
    
//    @IBAction func startButton(_ sender: Any) {
    
    @IBAction func startButton(_ sender: Any) {
    
    performSegue(withIdentifier: "seguetwo", sender: self)
        selectedImage.transform = .identity
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
        imageForGridy = pickedImage
        processPicked(image: imageForGridy)
    }
 // selectedImage
    func processPicked(image: UIImage?) {
        if let newImage = image {
            performSegue(withIdentifier: "segueTwo", sender: self)
        }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
      }

   }
}
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        if let image = newImage {
//            imageForGridy = image
//        }
//        picker.dismiss(animated: true) {
//            self.performSegue(withIdentifier: "segue2", sender: self)
//        }
//    }
//
//
//
//    override func prepare(for segue2: UIStoryboardSegue, sender: Any?) {
//        if segue2.identifier == "segue2" {
//            let vc = segue2.destination as! ViewControllerThree
//            vc.outGoingVC3  = imageForGridy
//        }
//    }
//}

//
//  ViewController.swift
//  gridy
//
//  Created by ollie on 24/07/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//  Giddy linked to github

import UIKit
import Photos
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    //MARK: Variables
    let picker = UIImagePickerController()
    var outGoingImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    @IBAction func unwindToStart(_ sender: UIStoryboardSegue) {
      }
  
    //MARK: IBActions
    @IBAction func cameraPhoto(_ sender: UIButton) {
        AccessCamera()
    }
    
    @IBAction func libraryImage(_ sender: UIButton) {
        AccessLibrary()
    }
    
    @IBAction func pickImage(_ sender: UIButton) {
   
        let localImages = [UIImage(named: "Random-Boats"),UIImage(named: "Random-Car"), UIImage(named: "Random-Crocodile"), UIImage(named: "Random-Park"), UIImage(named: "Random-TShirts")]
        
        let imgIndex = Int.random(in: 0...localImages.count - 1)
        outGoingImage = localImages[imgIndex]
        performSegue(withIdentifier: "segue", sender: self)
    }
        
    func troubleAlert(message: String?) {
        let alert = UIAlertController(title: "Oops...", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "got it", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func AccessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            let noPermissionMessage = "Looks like Gridy doesn't have permission to access the camera!"
            
            switch status {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        self.presentImagePicker(.camera)
                    } else {
                        self.troubleAlert(message: noPermissionMessage)
                    }
                }
            case .authorized:
                presentImagePicker(.camera)
            case .denied, .restricted:
                troubleAlert(message: noPermissionMessage)
            @unknown default:
                troubleAlert(message: "An unknown error occured, please try again")
            }
        } else {
            troubleAlert(message: "Looks like Gridy can't access your camera right now, please try again later!")
        }
    }
    
    func presentImagePicker(_ sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = sourceType
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func AccessLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let status = PHPhotoLibrary.authorizationStatus()
            let noPermissionMessage = "Looks like Gridy doesn't have permission to access your photos!"
            
            switch status {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { newStatus in
                    if newStatus == .authorized {
                        self.presentImagePicker(.photoLibrary)
                    } else {
                        self.troubleAlert(message: noPermissionMessage)
                    }
                }
            case .authorized:
                presentImagePicker(.photoLibrary)
            case .denied, .restricted:
                troubleAlert(message: noPermissionMessage)
            @unknown default:
                troubleAlert(message: "Looks like Gridy can't access your photo library right now, please try again later!")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if let image = newImage {
            outGoingImage = image
        }
        picker.dismiss(animated: true) {
            self.performSegue(withIdentifier: "segue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let vc = segue.destination as! ViewControllerTwo
            vc.receivedImage = outGoingImage!
        }
    }
}


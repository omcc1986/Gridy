//
//  GameViewController.swift
//  gridy
//
//  Created by ollie on 12/20/19.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import UIKit

public class GameViewController: UIViewController {
    
    
    @IBOutlet private weak var topColletionView: TopCollectionView!
    @IBOutlet private weak var bottomCollectionView: BottomCollectionView!
    
    public var received: [UIImage]!

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        topColletionView.images = received.shuffled()
        bottomCollectionView.correctImages = received
        
    }

}

//
//  gameCollectionView.swift
//  gridy
//
//  Created by ollie on 03/12/2019.
//  Copyright © 2019 Oliver McConnie. All rights reserved.
//

import UIKit

class gameCollectionView: UICollectionView {
        
        private var images: [UIImage] = []
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.delegate = self
            self.dataSource = self
            self.dropDelegate = self
        }
    }

    extension gameCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            #warning("Function is unfinished")
            
            
            return UICollectionViewCell()
        }
        
        
    }

    extension gameCollectionView: UICollectionViewDropDelegate {
        func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
            #warning("Function is unfinished")
    
            
        }
    }


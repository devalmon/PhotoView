//
//  UnsplashViewController.swift
//  PhotoView
//
//  Created by Alexey Baryshnikov on 16/09/2019.
//  Copyright © 2019 Alexey Baryshnikov. All rights reserved.
//

import UIKit
import UnsplashPhotoPicker

private let accessKey = "cd6ac1623c39cfce21be8f06ebe60713c0f510dbaaf986b8b8154c7d5c5cbcbe"
private let secretKey = "dab6c4318fae59961348e3fd864f4db7592445d3a59bdcb0f005281ed977a1c2"
private let reuseID = "unsplashCell"

class UnsplashViewController: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        guard let url = URL(string: "https://source.unsplash.com/random") else { return cell }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(data)
            print(response)
        }.resume()
        
        return cell
    }
    
    let config = UnsplashPhotoPickerConfiguration(accessKey: accessKey, secretKey: secretKey)
    
    
}

extension UnsplashViewController: UnsplashPhotoPickerDelegate {
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        print("selected")
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        print("canceled")
    }
    
    
}

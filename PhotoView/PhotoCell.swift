//
//  PhotoCell.swift
//  PhotoView
//
//  Created by Alexey Baryshnikov on 15/09/2019.
//  Copyright © 2019 Alexey Baryshnikov. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    var titleLabel = ""

    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        return activityIndicator
    }()

    var imageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func set(image: UIImage?) {
        imageView.image = image
        
        if image == nil {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    
    private func setupView() {
        backgroundColor = .lightGray
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
        clipsToBounds = true
        
        
        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let hc = imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let vc = imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let wc = imageView.widthAnchor.constraint(equalTo: self.widthAnchor)
        let highc = imageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        NSLayoutConstraint.activate([hc, vc, wc, highc])
        
        addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let verticalConstraint = activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

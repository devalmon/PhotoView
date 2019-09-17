//
//  PhotoFullScreenViewController.swift
//  PhotoView
//
//  Created by Alexey Baryshnikov on 15/09/2019.
//  Copyright © 2019 Alexey Baryshnikov. All rights reserved.
//

import UIKit

class PhotoFullScreenViewController: UIViewController {
    
    var timer: Timer?
    let countdownSeconds: Double = 5
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        timer = Timer.scheduledTimer(timeInterval: countdownSeconds, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: false)
    }
    
    
    @objc func timerAction() {
        if timer != nil {
            timer?.invalidate()
            navigationController?.popViewController(animated: true)
        }
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
        view.backgroundColor = .white
        
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let hc = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vc = imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let wc = imageView.widthAnchor.constraint(equalTo: view.widthAnchor)
        let highc = imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        NSLayoutConstraint.activate([hc, vc, wc, highc])
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
}

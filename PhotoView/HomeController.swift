//
//  HomeController.swift
//  PhotoView
//
//  Created by Alexey Baryshnikov on 14/09/2019.
//  Copyright © 2019 Alexey Baryshnikov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"



class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {



    //local array of images
    
    var sampleImages = [UIImage(named: "1"), UIImage(named: "2.jpg"), UIImage(named: "3.jpg"), UIImage(named: "4.jpg"), UIImage(named: "5.jpg")]

    var totalPhotos = 0
    var selectedImage: (row: Int, imageView: PhotoFullScreenViewController)?
//    var totalImages = 0
    
//    var photoTasks = [Int: PhotoTask]()
    
    // server for images
    /*
    let localServerAddress = "http://192.168.0.40:3000"
    
    let picsumServerAddress = "https://picsum.photos"
    var picsumPosToImageIdMapper = [Int: Int]()
    
    var address = ""
    
    var selectedImage: (row: Int, imageView: PhotoFullScreenViewController)?
    
    let cellId = "cellId"
    
    var screenDimensions: CGSize?
 */
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        totalPhotos = sampleImages.count
        collectionView.backgroundColor = .white
        navigationItem.title = "Photos: \(totalPhotos)"
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Register cell classes
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return totalPhotos
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> PhotoCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
 /*
        guard let url = URL(string: self.getImageUrlFor(pos: indexPath.row)) else { return cell }
        
        cell.set(image: nil)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.set(image: image)
                    
                    if let selectedImage = self.selectedImage, selectedImage.row == indexPath.row {
                        selectedImage.imageView.set(image: image)
                    }
                }
            }
        }
        */
        cell.titleLabel = String(indexPath.row + 1)
        
        cell.imageView.image = sampleImages[indexPath.row]
        
//        var rowIndex = indexPath.row
//        let numberOfRecords: Int = self.sampleImages.count - 1
//        if (rowIndex < numberOfRecords) {
//            rowIndex += 1
//        } else {
//            rowIndex = 0
//        }
//
//        scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(HomeController.startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let currentImage = sampleImages[indexPath.row]
//        let imageCrop = currentImage!.getCropRatio()
        
        return CGSize(width: view.frame.width/2, height: view.frame.height/2)
        
//        return CGSize(width: view.frame.width, height: 200)
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoFullScreenViewController = PhotoFullScreenViewController()
        let image = (collectionView.cellForItem(at: indexPath) as! PhotoCell).imageView.image
        photoFullScreenViewController.set(image: image)
        selectedImage = (indexPath.row, photoFullScreenViewController)
        navigationController?.pushViewController(photoFullScreenViewController, animated: true)
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    /*
    func imageDownloaded(position: Int) {
        self.collectionView?.reloadItems(at: [IndexPath(row: position, section: 0)])
        
        if let selectedImage = self.selectedImage, selectedImage.row == position, let image = photoTasks[position]?.image {
            selectedImage.imageView.set(image: image)
        }
    }
    
    private func setupUsingPicsumServer() {
        address = picsumServerAddress
        
        guard let url = URL(string: "\(address)/list") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error getting the total count: ", error)
                self.displayInvalidServerAlert()
                return
            }
            
            guard let data = data else { return }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [[String: Any]] {
                
                // Skip first N pics
                let start = 10
                let count = responseJSON.count
                
                var pos = 0
                for i in start..<count {
                    guard let id = responseJSON[i]["id"] as? Int else { return }
                    self.picsumPosToImageIdMapper[pos] = id
                    pos += 1
                }
                
                self.finishedFetchingImagesInfo(totalImages: count - start)
            }
            }.resume()
    }
    
    private func setupUsingLocalServer() {
        address = localServerAddress
        
        guard let url = URL(string: "\(address)/total") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error getting the total count: ", error)
                self.displayInvalidServerAlert()
                return
            }
            
            guard let data = data else { return }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                guard let totalImages = responseJSON["totalImages"] as? Int else { return }
                self.finishedFetchingImagesInfo(totalImages: totalImages)
            }
            }.resume()
    }
    
    private func finishedFetchingImagesInfo(totalImages: Int) {
        DispatchQueue.main.async {
            self.setupImageTasks(totalImages: totalImages)
            self.totalImages = totalImages
            self.collectionView?.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupImageTasks(totalImages: Int) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        for i in 0..<totalImages {
            let url = URL(string: getImageUrlFor(pos: i))!
            let imageTask = PhotoTask(position: i, url: url, session: session, delegate: self as! PhotoTaskDownloadedDelegate)
            photoTasks[i] = imageTask
        }
    }
    
    private func displayInvalidServerAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Can't connect", message: "Can't connect to the '\(self.address)'.\nPlease make sure you have a server running at that address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
    
    internal func getImageUrlFor(pos: Int) -> String {
        let isPicsum = address.contains("picsum")
        
        if isPicsum {
            let id = picsumPosToImageIdMapper[pos]!
            return "\(address)/\(screenDimensions!.width)/\(screenDimensions!.height)/?image=\(id)"
        }
        
        return "\(address)/image/\(pos)"
    }
*/
}

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRation = CGFloat(self.size.width / self.size.height)
        return widthRation
    }
}


//
//  GallaryController.swift
//  Exercise 18, 20, 21, 22 Gallary App
//
//  Created by Abhishek Maurya on 07/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class GallaryController: UIViewController {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var customNavBar: CustomNavigationBar!
    
    var arrayOfJSON = [jsonStructure]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        customNavBar.leftButton.isHidden = true
        
        customNavBar.titleButton.addTarget(self, action: #selector(self.titleClicked), for: .touchUpInside)
        
        customNavBar.rightButton.addTarget(self, action: #selector(self.logoutClicked), for: .touchUpInside)
                
        let nib = UINib.init(nibName: "CustomCollectionCell", bundle: nil)
        photoCollectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionCell")
        
        loadData()

    }
    
    @objc func titleClicked() {
        photoCollectionView.reloadData()
    }
    
    @objc func logoutClicked() {
        //        log out functionality here
    }
    
    func loadData() {
        let jsonURL = URL(string: "https://picsum.photos/list")
        let session = URLSession(configuration: .ephemeral)
        let sessionTask = session.dataTask(with: jsonURL!) {[weak self](data, response, error) in
            do {
                if error == nil {
                    self?.arrayOfJSON = try JSONDecoder().decode([jsonStructure].self, from: data!)
                    DispatchQueue.main.async {
                        self?.photoCollectionView.reloadData()
                    }
                }
            }catch {
                //Can't load data
            }
        }
        sessionTask.resume()
    }
    
    
}

extension GallaryController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfJSON.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellWidth = (collectionView.bounds.width/2.0)-12
        let cellHeight = cellWidth*(3/4)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as! CustomCollectionCell
        let url = "https://picsum.photos/\(cellWidth)/\(cellHeight)?image=\(indexPath.row)"
        guard let imageURL = URL(string: url) else { return cell }
        UIImage.loadFrom(url: imageURL) { image in
            if let image = image {
                cell.loadImage(image: image)
            }
        }
        cell.loadAuthor(authorName: arrayOfJSON[indexPath.row].author)
    
        return cell
    }
    
    //    to set height and width of cell in proportion to screen size and maintaning aspect ration of 3:4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.bounds.width/2.0)-12
        let cellHeight = cellWidth*(3/4)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "PicturePreviewController") as! PicturePreviewController
        
        let imageWidth = self.view.bounds.width
        let imageHeight = self.view.bounds.height
        let imageurl = "https://picsum.photos/\(imageWidth)/\(imageHeight)?image=\(arrayOfJSON[indexPath.row].id)"
        guard let url = URL(string: imageurl) else { return }
        
        UIImage.loadFrom(url: url) { image in
            controller.imageView.image = image
            controller.authorNameLabel.text = self.arrayOfJSON[indexPath.row].author as String
            controller.authorLink = URL(string: self.arrayOfJSON[indexPath.row].author_url)
            controller.loadingIndicator.isHidden = true
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
    
}

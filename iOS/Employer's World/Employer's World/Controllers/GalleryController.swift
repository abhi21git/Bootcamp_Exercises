//
//  GalleryController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class GalleryController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UISearchBarDelegate, NSFetchedResultsControllerDelegate, Toastable {
    
    //  MARK: - Variables
    var isGalleryVC = true
    var googleImagesResponse = [GoogleImages]()
    var imageTitle = [String]()
    var imageURL = [String]()
    var thumbnailURL = [String]()
    var query = ""
    let cx = "018004629090563794309:4-knw3rlcoo"
    let key = "AIzaSyDIUO4kqd6rHZEbNg5-phC6z6-jmHD0jLI"
//    let cx = "018004629090563794309:4-knw3rlcoo"
//    let key = "AIzaSyDFTIW28gbTwjayShhM2M7qy5ar7RWIqY8"
    var start = 1
    var num = 10
    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<Employees> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = Employees.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        
        try! fetchResultController.performFetch()
        return fetchResultController
        
    }()
    
    //  MARK: - IBOutlets
    @IBOutlet weak var gallery: UICollectionView!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CollectionGalleryCell", bundle: nil)
        gallery.register(nib, forCellWithReuseIdentifier: "galleryCell")
        
        gallery.delegate = self
        gallery.dataSource = self
        
        configureUI()
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        if isGalleryVC {
            self.navigationItem.title = "Gallery"
        }
        else {
            self.navigationItem.title = "Google Images"
            self.definesPresentationContext = true
            showSearchBar()
        }
        
        
    }
    
    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Search for images on Google"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func imageSearch() {
        
        let urlString = "https://www.googleapis.com/customsearch/v1?q=\(query)&key=\(key)&cx=\(cx)&searchType=image&start=\(start)&num=\(num)"
        
        NetworkManager.sharedInstance.googleImageSearch(urlString: urlString, completion: {(data, responseError) in
            
            if let error = responseError {
                DispatchQueue.main.async {
                    self.showToast(controller: self, message: error.localizedDescription, seconds: 1.2)
                }
            }
            else {
                if data != nil {
                    DispatchQueue.global().async {
                        self.googleImagesResponse = [data as! GoogleImages]
                        for elements in self.googleImagesResponse {
                            for items in elements.items!{
                                self.imageTitle.append(items.title!)
                                self.imageURL.append(items.imageLink!)
                                self.thumbnailURL.append((items.imageDetails?.thumbnailLink)!)
                            }
                        }
                        DispatchQueue.main.async {
                            self.gallery.reloadData()
                        }
                    }
                }
            }
        })
    }
    
    func clearSearch() {
        googleImagesResponse.removeAll()
        imageTitle.removeAll()
        imageURL.removeAll()
        thumbnailURL.removeAll()
        gallery.reloadData()

    }
    
    
    
    //  MARK: - IBActions
    
    
    
}



//  MARK: - Extensions
extension GalleryController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isGalleryVC {
            return 32
        }
        else {
            return imageURL.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! CollectionGalleryCell
        if isGalleryVC {
            
            return cell
        }
        else {
            let url = URL(string: thumbnailURL[indexPath.row])
            UIImage.loadFrom(url: url!, completion: { image in
                cell.thumbnailImage.image = image
                cell.loadingIndicator.isHidden = true
            })
            cell.imageTitle.isHidden = true
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isGalleryVC {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "PhotoPreviewController") as! PhotoPreviewController
            controller.isGoogleImage = false
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "PhotoPreviewController") as! PhotoPreviewController
            controller.imageURL = imageURL[indexPath.row]
            controller.isGoogleImage = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.width/2.0) - 15
        
        return CGSize(width: size, height: size)
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == imageURL.count - 1 {
//            start += 1
//            imageSearch()
//            gallery.reloadData()
//        }
//    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        clearSearch()
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
        let textField: UITextField = searchBar.value(forKey: "_searchField") as! UITextField
        textField.clearButtonMode = .never
        query = searchBar.text!.replacingOccurrences(of: " ", with: "%20")
        imageSearch()
    }

    
}

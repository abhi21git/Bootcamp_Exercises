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
    var isTabBarVC = true
    var googleImagesResponse = [GoogleImages]()
    var imageData = [GoogleImages]()
    var query = ""
    let cx = "018004629090563794309:4-knw3rlcoo"
    let key = "AIzaSyDFTIW28gbTwjayShhM2M7qy5ar7RWIqY8"
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
        if isTabBarVC {
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
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
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
                        for items in self.googleImagesResponse{
                            self.imageData = [items]
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
        gallery.reloadData()

    }
    
    
    
    //  MARK: - IBActions
    
    
    
}



//  MARK: - Extensions
extension GalleryController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isTabBarVC {
            return 32
        }
        else {
            var count = 0
            for items in imageData {
                count = items.items?.count ?? 0
            }
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! CollectionGalleryCell
        if isTabBarVC {
            
            return cell
        }
        else {
            var thumbnailLink: String?
            for items in imageData {
                thumbnailLink = items.items![indexPath.row].image?.thumbnailLink
                    let url = URL(string: thumbnailLink!)
                    UIImage.loadFrom(url: url!, completion: { image in
                        cell.thumbnailImage.image = image
                    })
            }
            cell.imageTitle.isHidden = true
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "PhotoPreviewController") as! PhotoPreviewController
        for items in imageData {
            controller.imageLink = items.items![indexPath.row].imageLink
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.width/2.0) - 15
        
        return CGSize(width: size, height: size)
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        for items in imageData {
//            if indexPath.row == items.items!.count - 1 {
//                start += 1
//                imageSearch()
//                gallery.reloadData()
//            }
//        }
//    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? true {
            clearSearch()
        }
        else {
            query = searchBar.text!.replacingOccurrences(of: " ", with: "%20")
            imageSearch()
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        clearSearch()
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }

    
}

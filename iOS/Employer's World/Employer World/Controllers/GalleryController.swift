//
//  GalleryController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class GalleryController: UIViewController, NSFetchedResultsControllerDelegate, Toastable {
    
    //  MARK: - Variables
    var refreshControl = UIRefreshControl()
    var isGalleryVC = true
    var isSelectionOn = false
    var googleImagesResponse = [GoogleImages]()
    var employeeName = [String]()
    var tempName = ""
    var imageURL = [String]()
    var thumbnailURL = [String]()
    var query = ""
    let cx = "018004629090563794309:4-knw3rlcoo"
    let key = "AIzaSyDIUO4kqd6rHZEbNg5-phC6z6-jmHD0jLI"
//    let cx = "018004629090563794309:4-knw3rlcoo"
//    let key = "AIzaSyDFTIW28gbTwjayShhM2M7qy5ar7RWIqY8"
    var start = 1
    var num = 10
    var temp = 0
    
    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<EmployeeImages> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = EmployeeImages.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "thumbnailURL", ascending: true)]
        
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        
        try? fetchResultController.performFetch()
        return fetchResultController
    }()
    
    //  MARK: - IBOutlets
    @IBOutlet weak var gallery: UICollectionView!
    @IBOutlet weak var selectButton: UIButton!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewHandling()
        configureUI()
        loadImages()
    }
    
    
    //  MARK: - Functions
    func collectionViewHandling() {
        let nib = UINib(nibName: "CollectionGalleryCell", bundle: nil)
        gallery.register(nib, forCellWithReuseIdentifier: "galleryCell")
        gallery.delegate = self
        gallery.dataSource = self

    }

    
    func configureUI() {
        if isGalleryVC {
            self.navigationItem.title = "Gallery"
            selectButton.isHidden = true
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
            gallery.refreshControl = refreshControl
        }
        else {
            self.navigationItem.title = "Google Images"
            self.definesPresentationContext = true
            selectButton.isHidden = false
            showSearchBar()
            
        }
        
    }
    
    
    func loadImages() {
        if isGalleryVC {
            for items in fetchedResultController.fetchedObjects! {
                employeeName.append(items.employeeName!)
                imageURL.append(items.imageURL!)
                thumbnailURL.append(items.thumbnailURL!)
            }
        }
        else {
            
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
        employeeName.removeAll()
        imageURL.removeAll()
        thumbnailURL.removeAll()
        gallery.reloadData()

    }
    
    
    
    //  MARK: - IBActions
    @IBAction func selectPressed() {
        if isSelectionOn {
            isSelectionOn = false
            selectButton.setTitle("Select", for: .normal)
        }
        else {
            isSelectionOn = true
            selectButton.setTitle("Done", for: .normal)
        }
    }
    
    @objc func refresh() {
        gallery.reloadData()
        refreshControl.endRefreshing()
    }

    
    
}



//  MARK: - Extensions
extension GalleryController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURL.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! CustomGalleryCell
        if isGalleryVC {
            cell.selectionIndicator.isHidden = true
            UIImage.loadFrom(url: thumbnailURL[indexPath.row], completion: { image in
                cell.thumbnailImage.image = image
                cell.imageTitle.text = self.tempName
                cell.loadingIndicator.isHidden = true
                cell.imageTitle.isHidden = false
                
            })
            return cell
        }
        else {
            
            UIImage.loadFrom(url: thumbnailURL[indexPath.row], completion: { image in
                cell.thumbnailImage.image = image
                cell.loadingIndicator.isHidden = true
            })
            cell.imageTitle.isHidden = true
            cell.selectionIndicator.isHidden = true
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = gallery.cellForItem(at: indexPath) as! CustomGalleryCell
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "PhotoPreviewController") as! PhotoPreviewController
        controller.imageURL = imageURL[indexPath.row]

        if isGalleryVC {
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
            if isSelectionOn {

                if currentCell.isUnselectedCell {
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    if let context = appDelegate?.persistentContainer.viewContext {
                        let entity = NSEntityDescription.insertNewObject(forEntityName: "EmployeeImages", into: context) as? EmployeeImages
                        entity?.employeeName = tempName
                        entity?.imageURL = imageURL[indexPath.row]
                        entity?.thumbnailURL = thumbnailURL[indexPath.row]
                        appDelegate?.saveContext()

                    }
                    currentCell.isUnselectedCell = false
                    currentCell.selectionIndicator.isHidden = false
                    currentCell.elevateView(shadowColor: UIColor(red: 0/255, green: 150/255, blue: 1, alpha: 1.0).cgColor, shadowRadius: 4, shadowOpacity: 1)
                    currentCell.thumbnailImage.layer.borderColor = UIColor(red: 0/255, green: 150/255, blue: 1, alpha: 1.0).cgColor
                    currentCell.thumbnailImage.layer.borderWidth = 2
                    
                }
                else {
                    //delete unselected image here
                    currentCell.elevateView(shadowColor: UIColor.white.cgColor, shadowRadius: 0, shadowOpacity: 0)
                    currentCell.isUnselectedCell = true
                    currentCell.selectionIndicator.isHidden = true
                    currentCell.thumbnailImage.layer.borderWidth = 0
                }
                
            }
            else {
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGFloat?
        
        if temp <= 2 {
            temp += 1
            cellSize = (collectionView.frame.width/3.0) - 8
        }
        else {
            temp += 1
            cellSize = (collectionView.frame.width/2.0) - 9
            if temp == 5 {
                temp = 0
            }
        }
        
        return CGSize(width: cellSize!, height: cellSize!)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            clearSearch()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let textField: UITextField = searchBar.value(forKey: "_searchField") as! UITextField
        textField.clearButtonMode = .never
        clearSearch()
        query = searchBar.text!.replacingOccurrences(of: " ", with: "%20")
        imageSearch()
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
    
    
}

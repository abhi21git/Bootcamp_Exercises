//
//  RecipiesController.swift
//  Exercise 23 Data Persistance
//
//  Created by Abhishek Maurya on 03/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class RecipiesController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<Recipe> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = Recipe.fetchRequest()
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        
        try? fetchResultController.performFetch()
        return fetchResultController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        urls[urls.count-1] as NSURL
        print(urls)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = "Recipes"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}






extension RecipiesController {
    // MARK: - Data Fetch
    
    
    
}

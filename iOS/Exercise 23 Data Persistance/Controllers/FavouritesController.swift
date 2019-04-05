//
//  FavouritesController.swift
//  Exercise 23 Data Persistance
//
//  Created by Abhishek Maurya on 03/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class FavouritesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favouriteTab: UITabBarItem!
    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<Recipe> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = Recipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "favorite == true")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "recipeName", ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        
        try! fetchResultController.performFetch()
        return fetchResultController
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RecipeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        self.navigationController?.navigationBar.topItem?.title = "Favourites"
    }
    
}





extension FavouritesController: NSFetchedResultsControllerDelegate {
    // MARK: - Data Fetch
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = fetchedResultController.fetchedObjects else {return 0}
        favouriteTab.badgeValue = String(result.count)
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! RecipeCell
        let recipe = fetchedResultController.object(at: indexPath)
        if recipe.favorite == true {
            cell.nameLabel.text = recipe.recipeName
            cell.chefLabel.text = "by: \(recipe.madeBy!)"
            cell.categoryLabel.text = "Category: \(recipe.category!)"
            cell.ingredientLabel.text = "Ingredients: \(recipe.recipeIngredient!)"
            cell.descriptionLabel.text = "Description:\n\(recipe.recipeDescription!)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // self.tableArray.remove(at: indexPath.row)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            let recipe1 = fetchedResultController.object(at: indexPath)
            context!.delete(recipe1)
            try? context!.save()
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .delete {
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
        }
        if type == .insert {
            let lastIndex = self.fetchedResultController.indexPath(forObject: anObject as! Recipe)
            tableView.insertRows(at: [lastIndex!], with: .fade)
        }
    }
}

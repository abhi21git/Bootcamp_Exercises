//
//  AddRecipeController.swift
//  Exercise 23 Data Persistance
//
//  Created by Abhishek Maurya on 04/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var recipeChefNameTextField: UITextField!
    @IBOutlet weak var recipeCategoryTextField: UITextField!
    @IBOutlet weak var recipeIngredientTextField: UITextField!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    @IBOutlet weak var recipeMakeFavouriteSwitch: UISwitch!
    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<Recipe> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = Recipe.fetchRequest()
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        
        try? fetchResultController.performFetch()
        return fetchResultController
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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




extension AddRecipeController {
    
    //MARK: - Recipe add functionality
    
    func addData() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let context = appDelegate?.persistentContainer.viewContext {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context) as? Recipe
            entity?.recipeName = recipeNameTextField.text!
            entity?.madeBy = recipeChefNameTextField.text!
            entity?.category = recipeCategoryTextField.text!
            entity?.recipeIngredient = recipeIngredientTextField.text!
            entity?.recipeDescription = recipeDescriptionTextView.text!
            entity?.favorite = recipeMakeFavouriteSwitch.isOn
            appDelegate?.saveContext()
        }
    }
    
    @IBAction func saveRecipe() {
        addData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

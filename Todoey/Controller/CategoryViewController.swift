//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Lucas Tramasso on 5/7/18.
//  Copyright © 2018 Lucas Tramasso. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoriesArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoriesArray[indexPath.row].name
        
        return cell
        
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories(){
        do {
            try context.save()
        } catch  {
            print ("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categoriesArray = try context.fetch(request)
        } catch {
            print ("Error fetching data from context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            if(textField.text! != ""){
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                self.categoriesArray.append(newCategory)
                self.saveCategories()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Category"
            alertTextField.autocapitalizationType = .sentences
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoriesArray[indexPath.row]
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

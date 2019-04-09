//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Daniela Tarantini on 20/03/2019.
//  Copyright © 2019 Daniela Tarantini. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController, UIAlertViewDelegate {
    
    var categories : [Category] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    //    MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
//        let category = categories[indexPath.row]
//        cell.textLabel?.text = category.name
//        IN REALTA è:
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
        
    }
    
    //    MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//                    context.delete(categories[indexPath.row])
//                    categories.remove(at: indexPath.row)
//                    saveNewCategory()
//                    loadCategories()
//
//        }
//    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        context.delete(arrayCate[indexPath.row])
//        arrayCate.remove(at: indexPath.row)
//        saveNewCategory()
//        loadCategory()
//
//
//    }
    

    
    //    MARK: Add New Categories

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New category", message: "Write the name", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "New category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveNewCategory()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        }
        
     //    MARK: - Data Manipulation Methods CRUD
    
    func saveNewCategory() {
        
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
        
//    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error loading request \(error)")
//        }
//
//        tableView.reloadData()
//    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    
    //    MARK: - Tableview Delegate Methods  --- non fare per ora
    
    
    
    
    
    
}

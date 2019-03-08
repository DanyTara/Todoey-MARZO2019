//
//  ViewController.swift
//  Todoey
//
//  Created by Daniela Tarantini on 08/03/2019.
//  Copyright © 2019 Daniela Tarantini. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]
    
   
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
    }


//    MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
            
        }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
//    MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(itemArray[indexPath.row])
        
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }

        
        
//        mi serve per togliere in grigio dalla riga selezionata
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    MARK - Add New Items
    
    
//    ricordarsi sequenza eventi. Se non creo la var textfield FUORI dalle clousure, non viene letta. E sopratutto riesco a temporeggiare gli eventi. Se la mettessi nella clousure, la closure temporalmnete avviene PRIMA della action, quindi sarebbe dispersa
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
//        what will happen once the user clicks the Add Items Button on our UIAlert
            
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
        }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            
            
        }
        
        
        
    }
    
    
    
    

    

    
    
    



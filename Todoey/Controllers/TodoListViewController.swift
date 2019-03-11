//
//  ViewController.swift
//  Todoey
//
//  Created by Daniela Tarantini on 08/03/2019.
//  Copyright © 2019 Daniela Tarantini. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defauts = UserDefaults.standard
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Armageddon"
        itemArray.append(newItem3)
        
        if let items = defauts.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
      
    }


//    MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        //        cell.accessoryType = item.done == true ? .checkmark : .none TERNARY OPERATOR DIVENTA:
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
            
        }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
//    MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
//  operatore booleano quindi con il simbolo !(NOT) si inverte
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defauts.set(self.itemArray, forKey: "TodoListArray")
            
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
    
    
    
    

    

    
    
    



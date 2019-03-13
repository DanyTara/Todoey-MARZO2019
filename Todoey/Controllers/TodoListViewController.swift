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
    
//    creo la directory per i miei dati (array) documens > Items.plist > aggiungo elementi (appending)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(dataFilePath)
        
        loadItems()
        
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
        
        saveData()
        
        
//        mi serve per togliere in grigio dalla riga selezionata
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    MARK - Add New Items
    
    
//    ricordarsi sequenza eventi. Se non creo la var textfield FUORI dalle clousure, non viene letta. E sopratutto riesco a temporeggiare gli eventi. Se la mettessi nella clousure, la closure temporalmente avviene PRIMA della action, quindi sarebbe dispersa
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
//        what will happen once the user clicks the Add Items Button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveData()
            
            
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
           
        }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
        }
    
    
//    Model Manipulation methods
    
//    ENCODE e DECODER permette di convertire i miei dati (array) in un plist e riconvertirli (decode) in dati
    func saveData() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        
//        creo il percorso
        if let data = try? Data(contentsOf: dataFilePath!){
//            creo una nuova variabile DECODER
            let decoder = PropertyListDecoder()
            
            do {
//              nel mio array metto il risultato del DECODE (specifico l'infer della mia classe array>Item dal percorso sopra -data-)
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array \(error)")
            }
            
        }
        
    }
    
}

    
    
    
    

    

    
    
    



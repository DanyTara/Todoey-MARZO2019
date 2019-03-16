//
//  ViewController.swift
//  Todoey
//
//  Created by Daniela Tarantini on 08/03/2019.
//  Copyright © 2019 Daniela Tarantini. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        //    creo la directory per i miei dati (array) documens > Items.plist > aggiungo elementi (appending)
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist"))
        
//        8 - scrivo qui la costante request (che è il mio array intero senza filtro) e la inserisco come parametro del loadItems
        //        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //        loadItems(with: request)
        
//         10 - torno al loadItem senza paramenbtro perché ho aggiunyo quello di default

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
  
     //        cruD: DELETE ( per ora rimane commentato perché teniamo la spunta del DONE
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        //        crUd: UPDATE
        
        
//  operatore booleano quindi con il simbolo !(NOT) si inverte
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
//        mi serve per togliere in grigio dalla riga selezionata
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    MARK - Add New Items
    
    
//    ricordarsi sequenza eventi. Se non creo la var textfield FUORI dalle clousure, non viene letta. E sopratutto riesco a temporeggiare gli eventi. Se la mettessi nella clousure, la closure temporalmente avviene PRIMA della action, quindi sarebbe dispersa
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //        Crud: CREATE
            
//        what will happen once the user clicks the Add Items Button on our UIAlert
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
            }
        
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
           
        }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
        }
    
    
//    Model Manipulation methods
    

    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
        }
    
    
    //        cRud: READ
    
//    4 -modifico la funzione scrivendo il parametro requesto DI TIPO NSFetchRequest che ritorna un array di tipo Item
//    func loadItems() {
//    5 - aggiungo with che è parametro esterno, request è paramentro interno. Ovvero quello chiamato all'interno della funzione
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {

//      7 - commento questa linea perché aggiungendo il parametro la richiesta è chiara e passo questa costante nell'overlaod dove devo ricaricare la tableview completa di tutti gli elementi
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //        - 9 : aggiungo il parametro di DEFAULt = Item.fetchRequest()
//        func loadItems(with request: NSFetchRequest<Item>) {

        do {
        itemArray = try context.fetch(request)
        } catch  {
            print("\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
}

//    MARK: - Search bar methods


extension TodoListViewController: UISearchBarDelegate {
    
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
            let request : NSFetchRequest<Item> = Item.fetchRequest()
            
//            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//            request.predicate = predicate
   //        1- QUESTO DIVENTA COSì:
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
            
//            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//            request.sortDescriptors = [sortDescriptor]
            // 2 - QUESTO DIVENTA COSì:
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
        
//        do {
//            itemArray = try context.fetch(request)
//        } catch  {
//            print("\(error)")
//        }
//        3 - ANZICHè RISCRVERE IL context.fetchRequest modifico la funzione loadItems con il parametro request
        loadItems(with: request)
//        6 -    e posso cancellare il reloadData che è gia contenuto nella funzione loadItems
//        tableView.reloadData()
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
           
        }
        
    }
    
    
    
}

    
    

    

    
    
    



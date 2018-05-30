//
//  ViewController.swift
//  TodoList
//
//  Created by Сергей Юханов on 22.05.2018.
//  Copyright © 2018 Yukhanov. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
        loadItems()
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        //MARK - Ternary operator
        // value = condition ? valueIsTrue : valueIsFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Добавьте новую задачу", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить задачу", style: .default) { (action) in
            //what will happen once the user clicks
  
            print(textField.text!)
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
          
            self.saveItems()
            
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Напиши задачу"
            textField = alertTextField
            
            
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            
            } catch {
                print("Error decoding \(error)")
            }
        }
        
    }

}


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
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "buy a milk"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Save the world!"
        itemArray.append(newItem3)
        if let items = defaults.array(forKey: "toDoListArray") as? [Item] {
            itemArray = items
        }
        
        
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
      
        
        tableView.reloadData()
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
            self.tableView.reloadData()
            
            self.defaults.set(self.itemArray, forKey: "toDoListArray")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Напиши задачу"
            textField = alertTextField
            
            
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}


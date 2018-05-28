//
//  ViewController.swift
//  TodoList
//
//  Created by Сергей Юханов on 22.05.2018.
//  Copyright © 2018 Yukhanov. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "toDoListArray") as? [String] {
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Добавьте новую задачу", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить задачу", style: .default) { (action) in
            //what will happen once the user clicks
            print("Нажали на кнопку!")
            print(textField.text!)
            self.itemArray.append(textField.text!)
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


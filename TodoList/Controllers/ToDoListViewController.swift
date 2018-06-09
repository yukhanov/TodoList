//
//  ViewController.swift
//  TodoList
//
//  Created by Сергей Юханов on 22.05.2018.
//  Copyright © 2018 Yukhanov. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    
    
    var selectedCategory : Category? {
        didSet {
             loadItems()
        }
    }
    
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            //MARK - Ternary operator
            // value = condition ? valueIsTrue : valueIsFalse
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "Задачи пока не были добавлены"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    
                    item.done = !item.done
                }
            } catch {
                print("error saving status \(error)")
            }
        }
        
        tableView.reloadData()
        //print(todoItems[indexPath.row])
        
//        context.delete(todoItems[indexPath.row])
//        todoItems.remove(at: indexPath.row)
        
       // todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//        self.saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавьте новую задачу", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить задачу", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                } catch {
                    print("error saving new items\(error)")
                }
            }
            self.tableView.reloadData()
        }
      
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Напиши задачу"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//    func saveItems() {
//
//
//        do {
//            try context.save()
//
//        } catch {
//            print("Не удается сохранить контент\(error)")
//        }
//
//        self.tableView.reloadData()
//    }
    
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()

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

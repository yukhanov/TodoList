//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Сергей Юханов on 05.06.2018.
//  Copyright © 2018 Yukhanov. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {

    var categories: Results<Category>?
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    
    //MARK: - TableView DataSource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
           return categories?.count ?? 1
        
    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            guard let categoryColor = UIColor(hexString: category.colour) else {fatalError()}
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // seague to TDLController
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
            
        
        
    }

    
    
    //MARK: - ADD new categories
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        var tField = UITextField()
        let alert = UIAlertController(title: "Добавьте новый раздел", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить", style: .default, handler: { (action) in
            
            let newCat = Category()
            newCat.name = tField.text!
            newCat.colour = UIColor.randomFlat.hexValue()
            
            
            self.save(category: newCat)
        })
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Например, Покупки"
            tField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Data manipulation method
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Не удается сохранить категорию \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        

    }
    
    //MARK: - Add delete data from DB with swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDelete = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                self.realm.delete(categoryForDelete)
                    }
            } catch {
                print("Не удается удалить элемент свайпом \(error)")
            }
        }
    }
}







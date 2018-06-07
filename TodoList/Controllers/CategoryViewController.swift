//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Сергей Юханов on 05.06.2018.
//  Copyright © 2018 Yukhanov. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - TableView DataSource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let cat = categoryArray[indexPath.row]
        cell.textLabel?.text = cat.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // seague to TDLController
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
            
        
        
    }

    
    
    //MARK: - ADD new categories
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        var tField = UITextField()
        let alert = UIAlertController(title: "Добавьте новый раздел", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить", style: .default, handler: { (action) in
            
            let newCat = Category(context: self.context)
            newCat.name = tField.text!
            
            self.categoryArray.append(newCat)
            self.saveCategories()
        })
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Например, Покупки"
            tField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Data manipulation method
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Не удается сохранить категорию \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
          categoryArray = try context.fetch(request)
        } catch {
            print("Не удается получить данные для загрузки")
        }
    }
    
    //MARK: - TableView Delegate method
   

}

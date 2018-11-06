//
//  CategoryTableViewController.swift
//  Todo List
//
//  Created by Amr Reda on 10/28/18.
//  Copyright © 2018 Amr Reda. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    var categoryCell = "CategoryCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    //MARK: - TableView Data source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCell, for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet"
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation
    
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            print("Error in saving context, \(error)")
        }
        
        
        tableView.reloadData()
    }
    
    func loadData(){
        
        categories = realm.objects(Category.self) // this will pulll out all of the items inside realm that of category object
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add Button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (alert) in
            // what will happen when i press the add button
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "Create new Category"
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
}

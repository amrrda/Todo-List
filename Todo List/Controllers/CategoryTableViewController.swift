//
//  CategoryTableViewController.swift
//  Todo List
//
//  Created by Amr Reda on 10/28/18.
//  Copyright © 2018 Amr Reda. All rights reserved.
//

import UIKit
import CoreData

var categories = [Category]()
var categoryCell = "CategoryCell"

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


class CategoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    //MARK: - TableView Data source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCell, for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation
    
    func saveData(){
        
        do {
            try context.save()
            
        } catch {
            print("Error in saving context, \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    func loadData(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try context.fetch(request)
        } catch {
            print("\(error)")
        }
    }
    
    
    //MARK: - Add Button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (alert) in
            // what will happen when i press the add button
            
            let newCategory = Category(context: context)
            newCategory.name = textField.text
            categories.append(newCategory)
            
            self.saveData()
        }
        
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "Create new Category"
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
}

//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by saw Tarmalar on 19/06/2020.
//  Copyright © 2020 saw Tarmalar. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework


class CategoryTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
       
        loadCategory()
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    //MARK : Tableview DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
//        if let category = categories?[indexPath.row]{
//            cell.textLabel?.text = category.name ?? "No Categories added yet"
//
//            cell.backgroundColor = UIColor(hexString: category.color ?? "1D9bF6")
//        }
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "1D9bF6")
        
       
        return cell
    }
    
    //MARK : Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories![indexPath.row]
        }
    }
    

    @IBAction func pressedBarButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
     
            self.saveCategory(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory(category: Category){
            do{
                try realm.write{
                    realm.add(category)
                
                }
            }catch{
                print("Error saving context \(error)")
            }
            tableView.reloadData()
        }
        

        
        func loadCategory() {
            categories = realm.objects(Category.self)
            tableView.reloadData()
    }
    
    //MARK - delete data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)
            if let categoryForDeletion = self.categories?[indexPath.row]{
                do{
                    try self.realm.write{
                        self.realm.delete(categoryForDeletion)
                    }
                }catch{
                    print("Error deleting category, \(error)")
                }

            }
    }
}


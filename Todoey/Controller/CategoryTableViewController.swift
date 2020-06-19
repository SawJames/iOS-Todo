//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by saw Tarmalar on 19/06/2020.
//  Copyright © 2020 saw Tarmalar. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        loadCategory(with: request)
    }
    
    //MARK : Tableview DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let  category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(categoryArray[indexPath.row])
    }
    

    @IBAction func pressedBarButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory(){
            do{
                try context.save()
            }catch{
                print("Error saving context \(error)")
            }
            self.tableView.reloadData()
        }
        

        
        func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest() ) {
    //        let request : NSFetchRequest<Item> = Item.fetchRequest()
            do {
                categoryArray = try context.fetch(request)
            } catch {
                print("error fetching data from context \(error)")
            }
             tableView.reloadData()
        }
}

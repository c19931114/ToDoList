//
//  ViewController.swift
//  ToDoList
//
//  Created by Crystal on 2018/8/28.
//  Copyright © 2018年 Crystal. All rights reserved.
//

import UIKit

class ToDoListTableVC: UIViewController {
    
    var selectedItem: Int?

    @IBAction func addItem(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showContentVC", sender: nil)

    }
    
    @IBOutlet weak var toDoListTableView: UITableView!
    
    var toDoItems = ["吃飯", "睡覺", "打東東"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "To Do List"
        setCell()
        
    }
    
    func setCell() {
        
        let toDoNib = UINib(nibName: "ToDoListTableViewCell", bundle: nil)
        toDoListTableView.register(toDoNib, forCellReuseIdentifier: "toDoCell")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addOrEditVC: AddOrEditVC = segue.destination as? AddOrEditVC {
            addOrEditVC.delegate = self
        }
    }

}

extension ToDoListTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell",
                                                    for: indexPath) as? ToDoListTableViewCell {
            
            let cellIndexPath = toDoItems[indexPath.row]
            
            cell.toDoItemLabel.text = cellIndexPath
            
            //target action
            cell.editButton.tag = indexPath.row
            cell.editButton.addTarget(self, action: #selector(editToDoItem(sender:)), for: .touchUpInside)
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @objc func editToDoItem(sender: UIButton) {
        
        selectedItem = sender.tag
        print(sender.tag)
        
        let itemContent = toDoItems[selectedItem!]
        let editContentVC = AddOrEditVC.editSelectedItem(itemContent)
        editContentVC.delegate = self
        navigationController?.pushViewController(editContentVC, animated: true)
    
    }
    
}

extension ToDoListTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension

    }
    
}

extension ToDoListTableVC: DataSentDelegate {
    
    func updateItem(data: String) {
        
        if selectedItem != nil {
            
            guard let selectedItem = selectedItem else { return }
            toDoItems[selectedItem] = data
            
            self.selectedItem = nil
            toDoListTableView.reloadData()


        } else {
            
            toDoItems.append(data)
            toDoListTableView.reloadData()
        }
        
    }
    
}




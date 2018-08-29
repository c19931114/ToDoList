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
    
    var observation: NSKeyValueObservation?

    @IBAction func addItem(_ sender: Any) {
        
        
        let addContentVC = AddOrEditVC.editSelectedItem("")
        
        self.observation = addContentVC.observe(\.content, options: [.new], changeHandler: { (addContentVC, _) in
            
            guard let content = addContentVC.content else { return }
            self.toDoItems.append(content)

            self.navigationController?.popViewController(animated: true)
            self.toDoListTableView.reloadData()
            
        })

        navigationController?.pushViewController(addContentVC, animated: true)
        
    }
    
    @IBOutlet weak var toDoListTableView: UITableView!
    
    var toDoItems = ["吃飯", "睡覺", "打東東"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "To Do List"
        setCell()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setCell() {
        
        let toDoNib = UINib(nibName: "ToDoListTableViewCell", bundle: nil)
        toDoListTableView.register(toDoNib, forCellReuseIdentifier: "toDoCell")
        
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
        
        self.observation = editContentVC.observe(\.content, options: [.new], changeHandler: { (editContentVC, _) in
            
            guard let content = editContentVC.content else { return }
          
            guard let selectedItem = self.selectedItem else { return }
            self.toDoItems[selectedItem] = content
            
            self.navigationController?.popViewController(animated: true)
            self.toDoListTableView.reloadData()

        })
        navigationController?.pushViewController(editContentVC, animated: true)
        
    }
    
}

extension ToDoListTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension

    }
    
}




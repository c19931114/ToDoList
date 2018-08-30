//
//  ViewController.swift
//  ToDoList
//
//  Created by Crystal on 2018/8/28.
//  Copyright © 2018年 Crystal. All rights reserved.
//

import UIKit

struct NotificationInfo {
    static let message = ""
}

class ToDoListTableVC: UIViewController {
    
    var toDoItems = ["吃飯", "睡覺", "打東東"]
    var selectedItem = UIButton().tag

    @IBAction func addItem(_ sender: Any) {
        
        let nilContent = AddOrEditVC.editSelectedItem("")
        navigationController?.pushViewController(nilContent, animated: true)
        
    }
    
    @IBOutlet weak var toDoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "To Do List"
        setCell()
        
        let addNotificationName = Notification.Name.add
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(gotAddNotification),
            name: addNotificationName, object: nil)
        // object 填入特定接收對象 (不想接收所有 notification 時)
        
        let editNotificationName = Notification.Name.edit
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(gotEditNotification),
            name: editNotificationName, object: nil)
  
    }
    
    @objc func gotAddNotification(noti: Notification) {
        
        guard let userInfo = noti.userInfo,
            let message = userInfo[NotificationInfo.message] else { return }
        
        print(message)
        
        guard let todoItem = noti.object as? String else {
            return
        }
        
        toDoItems.append(todoItem)
        toDoListTableView.reloadData()
    }

    
    @objc func gotEditNotification(noti: Notification) {
        
        guard let userInfo = noti.userInfo,
            let message = userInfo[NotificationInfo.message] else { return }
        
        print(message)
        
        guard let todoItem = noti.object as? String else {
            return
        }
    
        toDoItems[selectedItem] = todoItem
        toDoListTableView.reloadData()
        
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
        
        let toDoItem = toDoItems[selectedItem]
        
        let editItem = AddOrEditVC.editSelectedItem(toDoItem)
        navigationController?.pushViewController(editItem, animated: true)

        
    }
    
}

extension ToDoListTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension

    }
    
}




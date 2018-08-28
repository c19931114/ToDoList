//
//  AddOrEditVC.swift
//  ToDoList
//
//  Created by Crystal on 2018/8/28.
//  Copyright © 2018年 Crystal. All rights reserved.
//

import UIKit

class AddOrEditVC: UIViewController {
    
    @IBOutlet weak var itemContent: UITextView!
    
    static let storyboardName = "Main"
    static let viewControllerIdentifier = "addOrEditVC"
    var content = ""
    
    class func editSelectedItem(_ content: String) -> AddOrEditVC {
        
        let thisStoryboard = UIStoryboard(name: AddOrEditVC.storyboardName, bundle: nil)
        
        guard let addOrEditVC = thisStoryboard.instantiateViewController(withIdentifier: AddOrEditVC.viewControllerIdentifier) as? AddOrEditVC else {
            
            return AddOrEditVC()
        }
        
        addOrEditVC.content = content
        
        return addOrEditVC

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBartitle()
        itemContent.text = content

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func setNavigationBartitle() {
        
        self.navigationItem.title = "Add"
    }

}

//
//  AddOrEditVC.swift
//  ToDoList
//
//  Created by Crystal on 2018/8/28.
//  Copyright © 2018年 Crystal. All rights reserved.
//

import UIKit

class AddOrEditVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBartitle()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func setNavigationBartitle() {
        
        self.navigationItem.title = "Add"
    }

}

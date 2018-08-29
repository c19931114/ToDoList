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
    var content: String?
    
    class func editSelectedItem(_ content: String) -> AddOrEditVC {
        
        let mainStoryboard = UIStoryboard(name: AddOrEditVC.storyboardName, bundle: nil)
        
        guard let addOrEditVC = mainStoryboard.instantiateViewController(withIdentifier: AddOrEditVC.viewControllerIdentifier) as? AddOrEditVC else {
            return AddOrEditVC()
        } // 告訴 addOrEditVC 要讀 storboard 的哪個畫面
            //直接 new 會是黑畫面(因為我們是用 storyboard 製作畫面)
        
        if content == "" {
            
            addOrEditVC.navigationItem.title = "Add"
        } else {
            
            addOrEditVC.navigationItem.title = "Edit"
        }
        
        addOrEditVC.content = content
        
        return addOrEditVC

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemContent.text = content

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//
//  TypePageViewController.swift
//  upperHandMVP
//
//  Created by Parth Patel on 2/5/23.
//

import UIKit
import CoreData

class TypePageViewController: UIViewController {

    @IBOutlet weak var DisplayFavorite: UITextView!
    
    var favoriteContent = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (favoriteContent != "") {
            DisplayFavorite.text = favoriteContent
        }
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == DisplayFavorite {
            DisplayFavorite.text = favoriteContent
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    
    var selectedFavorite: Favorite? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DisplayFavorite.text = favoriteContent
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if (selectedFavorite == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newFavorite = Favorite(entity: entity!, insertInto: context)
            newFavorite.id = favoritesList.count as NSNumber
            newFavorite.text = DisplayFavorite.text
            do
            {
                try context.save()
                favoritesList.append(newFavorite)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("context save error")
            }
        }
        else //edit
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let favorite = result as! Favorite
                    if(favorite == selectedFavorite)
                    {
                        favorite.text = DisplayFavorite.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
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

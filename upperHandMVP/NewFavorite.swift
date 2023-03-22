import UIKit
import CoreData

class NewFavoriteViewController: UIViewController
{
    @IBOutlet weak var favoritesText: UITextView!
    
    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let newFavorite = Favorite(entity: entity!, insertInto: context)
        newFavorite.id = favoritesList.count as NSNumber
        newFavorite.text = favoritesText.text
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
}

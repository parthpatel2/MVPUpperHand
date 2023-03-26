import UIKit
import CoreData

class NewFavoriteViewController: UIViewController
{
    @IBOutlet weak var favoritesText: UITextView!
    
    var selectedFavorite: Single_Favorite? = nil
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(selectedFavorite != nil)
        {
            favoritesText.text = selectedFavorite?.text
        }
    }

    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Single_Favorite", in: context)
        let newFavorite = Single_Favorite(entity: entity!, insertInto: context)
        newFavorite.id = Int32(favoritesList.count)
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

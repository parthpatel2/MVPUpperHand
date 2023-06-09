import UIKit
import CoreData

class NewFavoriteViewController: UIViewController
{
    @IBOutlet weak var favoritesText: UITextView!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var selectedFavorite: Single_Favorite? = nil
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(selectedFavorite != nil)
        {
            favoritesText.text = selectedFavorite?.text
            favoriteLabel.text = "Edit Favorite"
        }
    }

    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if (selectedFavorite == nil) {
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
        else //edit
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Single_Favorite")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let favorite = result as! Single_Favorite
                    if(favorite == selectedFavorite)
                    {
                        favorite.text = favoritesText.text
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
    @IBAction func deletedFavorite(_ sender: Any) {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Single_Favorite")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let favorite = result as! Single_Favorite
                if(favorite == selectedFavorite)
                {
                    favorite.deletedDate = Date()
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

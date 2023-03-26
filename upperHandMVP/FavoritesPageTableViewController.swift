//
//  FavoritesPageTableViewController.swift
//  upperHandMVP
//
//  Created by Parth Patel on 2/1/23.
//

import UIKit
import CoreData

var favoritesList = [Single_Favorite]()

class FavoritesPageTableViewController: UITableViewController, UISearchBarDelegate {
    
    var firstLoad = true
    
    var selectedIP: IndexPath?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData: [Single_Favorite]!
    
    func nonDeletedFavorites() -> [Single_Favorite]
    {
        var noDeleteFavoritesList = [Single_Favorite]()
        for favorite in filteredData
        {
            if (favorite.deletedDate == nil)
            {
                noDeleteFavoritesList.append(favorite)
            }
        }
        return noDeleteFavoritesList
    }
    
    override func viewDidLoad() {
        if (firstLoad)
        {
            favoritesList = []
            firstLoad = false
            let appDelegate =  UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Single_Favorite")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let favorite = result as! Single_Favorite
                    favoritesList.append(favorite)
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
            
        searchBar.delegate = self
        
        filteredData = favoritesList
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    @IBOutlet weak var didClickFavorite: UITableViewCell!
     
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nonDeletedFavorites().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favoritecellID")! as! FavoriteCell

        
        let thisFavorite: Single_Favorite!
        thisFavorite = nonDeletedFavorites()[indexPath.row]
        
        favoriteCell.favoritesLabel.text = thisFavorite.text;
        
        return favoriteCell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func editButton(_ sender: UIButton!) {
        var superview = sender.superview
            while let view = superview, !(view is UITableViewCell) {
                superview = view.superview
            }
            guard let cell = superview as? UITableViewCell else {
                print("button is not contained in a table view cell")
                return
            }
            selectedIP = tableView.indexPath(for: cell)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editFavorite")
        {
            let indexPath = selectedIP
            
            let favoriteDetail = segue.destination as? NewFavoriteViewController
            
            let selectedFavorite : Single_Favorite!
            selectedFavorite = nonDeletedFavorites()[indexPath!.row]
            favoriteDetail?.selectedFavorite = selectedFavorite
            
            tableView.deselectRow(at: indexPath!, animated: true)
        }
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Mark:
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = [];
        
        if searchText == "" {
            filteredData = nonDeletedFavorites();
        } else {
            for favorite in nonDeletedFavorites() {
                if (favorite.text!.lowercased().contains(searchText.lowercased())) {
                    filteredData.append(favorite)
                }
            }
        }
        self.tableView.reloadData()
    }

}

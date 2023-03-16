//
//  FavoritesPageTableViewController.swift
//  upperHandMVP
//
//  Created by Parth Patel on 2/1/23.
//

import UIKit

class FavoritesPageTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let data = ["stove", "oven", "fridge", "sink", "countertop", "utensils", "cookware", "dishware", "cutlery", "spices", "microwave", "toaster", "blender", "coffee maker", "teapot", "pot", "pan", "grill", "food processor", "mixer", "chopper", "pressure cooker", "slow cooker", "air fryer", "deep fryer", "rice cooker", "bakeware", "serving dishes", "platters", "casserole dishes", "pie dish", "muffin tin", "loaf pan", "cookie sheet", "pizza stone", "cutting board", "measuring cups", "measuring spoons", "can opener", "peeler", "grater", "strainer", "whisk", "spatula", "tongs", "ladle", "fork", "knife", "spoon", "rolling pin", "cooling rack", "dish towel", "pot holders", "apron", "oven mitts", "kitchen timer", "scale"]
   
    
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        searchBar.delegate = self
        
        filteredData = data
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
        return filteredData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell

        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
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
            filteredData = data;
        } else {
            for favorite in data {
                if favorite.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(favorite)
                }
            }
        }
        self.tableView.reloadData()
    }

}

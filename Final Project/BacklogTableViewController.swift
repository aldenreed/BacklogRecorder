//
//  BacklogTableViewController.swift
//  Final Project
//
//  Created by Alden Reed on 7/7/17.
//  Copyright © 2017 Alden Reed. All rights reserved.
//

import UIKit
import Foundation

class BacklogTableViewController: UITableViewController, UISearchBarDelegate {
    
    //var games:[BacklogEntry] = []
    var searchResults:[BacklogEntry] = []
    var searchActive = false
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    func addGame(){
        searchActive = false
        let game = BacklogEntry(name: "", system: "", genre: "", developer: "", publisher: "", region: "")
        BackEntries.games.append(game)
        let newIndexPath = IndexPath(row: BackEntries.games.count - 1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
    }

    override func viewDidLoad() {
        let nocturne = BacklogEntry(name: "SMT III: Nocturne", system: "PS2", genre: "JRPG", developer: "Atlus", publisher: "Atlus", region: "NTSC")
        BackEntries.games.append(nocturne)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(BacklogTableViewController.addGame))
        navigationItem.rightBarButtonItem = addButton
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(searchActive && searchBar.text! != ""){
            return searchResults.count
        }
        return BackEntries.games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = tableView.dequeueReusableCell(withIdentifier: "game", for: indexPath)
        let game: BacklogEntry
        if(searchActive && searchBar.text! != ""){
            game = searchResults[indexPath.row]
        }else{
            game = BackEntries.games[indexPath.row]
        }
        let name = game.name
        if(name == ""){
            entry.textLabel?.text = "No Name"
        }else{
            entry.textLabel?.text = name
        }
        return entry
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(searchActive && searchResults.count > 0){
                var i = 0;
                while(BackEntries.games[indexPath.row].name != searchResults[i].name && i < searchResults.count){
                    i += 1
                }
                searchResults.remove(at: i)
            }
            BackEntries.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*func filterContent(searchText: String){
        self.searchResults = BackEntries.games.filter({(aGame: BacklogEntry) -> Bool in
            return aGame.name.lowercased().range(of: searchText.lowercased()) != nil})
    }
    
    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool{
        self.filterContent(searchText: searchString)
        return true
    }*/
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = BackEntries.games.filter({(game) -> Bool in
            return game.name.contains(searchText)
        })
        if(searchResults.count == 0){
            searchActive = false
        }else{
            searchActive = true
        }
        self.tableView.reloadData()
    }

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        let entry: BacklogEntry
        if(searchActive && searchBar.text! != ""){
            entry = searchResults[indexPath!.row]
        }else{
            entry = BackEntries.games[indexPath!.row]
        }
        let destination = segue.destination as! BacklogDetailViewController
        destination.entry = entry
        searchActive = false
        searchBar.text! = ""
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    override func viewWillAppear(_ animated: Bool) {
        searchBar.text! = ""
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

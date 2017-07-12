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
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(BacklogTableViewController.addGame))
        navigationItem.rightBarButtonItem = addButton
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

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
    }

    override func viewWillAppear(_ animated: Bool) {
        searchBar.text! = ""
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

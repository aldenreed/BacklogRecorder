//
//  PlayingTableViewController.swift
//  Final Project
//
//  Created by Alden Reed on 7/8/17.
//  Copyright © 2017 Alden Reed. All rights reserved.
//

import UIKit

class PlayingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayingEntries.games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = tableView.dequeueReusableCell(withIdentifier: "game", for: indexPath)
        let game = PlayingEntries.games[indexPath.row]
        if(game.name == ""){
            entry.textLabel?.text = "No Name"
        }else{
            entry.textLabel?.text = game.name
        }
        return entry
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

//
//  StatsViewController.swift
//  Final Project
//
//  Created by Alden Reed on 7/9/17.
//  Copyright © 2017 Alden Reed. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    @IBOutlet weak var colCount: UILabel!
    @IBOutlet weak var backCount: UILabel!
    @IBOutlet weak var playingCount: UILabel!
    @IBOutlet weak var ratio: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        colCount.text = String(ColEntries.games.count)
        backCount.text = String(BackEntries.games.count)
        playingCount.text = String(PlayingEntries.games.count)
        let total = Double(ColEntries.games.count) / Double(ColEntries.games.count + BackEntries.games.count)
        if(total == 0){
            ratio.text = "0.0"
        }else{
            ratio.text = String(total)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
    }
}

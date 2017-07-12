//
//  BacklogDetailViewController.swift
//  Final Project
//
//  Created by Alden Reed on 7/7/17.
//  Copyright © 2017 Alden Reed. All rights reserved.
//

import UIKit

class BacklogDetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var gameField: UITextField!
    @IBOutlet weak var systemField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var devField: UITextField!
    @IBOutlet weak var pubField: UITextField!
    @IBOutlet weak var regionField: UITextField!
    @IBOutlet weak var moveButton: UIButton!
    var entry: BacklogEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameField.delegate = self
        self.systemField.delegate = self
        self.genreField.delegate = self
        self.devField.delegate = self
        self.pubField.delegate = self
        self.regionField.delegate = self
        if let entry = self.entry{
            self.gameField.text = entry.name
            self.systemField.text = entry.system
            if let genre = entry.genre{
                self.genreField.text = genre
            }
            if let dev = entry.developer{
                self.devField.text = dev
            }
            if let pub = entry.publisher{
                self.pubField.text = pub
            }
            if let region = entry.region{
                self.regionField.text = region
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == self.gameField){
            self.entry?.name = gameField.text!
        }
        else if(textField == self.systemField){
            self.entry?.system = systemField.text!
        }
        else if(textField == self.genreField){
            self.entry?.genre = genreField.text!
        }
        else if(textField == self.devField){
            self.entry?.developer = devField.text!
        }
        else if(textField == self.pubField){
            self.entry?.publisher = pubField.text!
        }
        else if(textField == self.regionField){
            self.entry?.region = regionField.text!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func moveToCollection(_ sender: Any) {
        let alertController = UIAlertController(title: "Move to Collection", message: "This will add the game to the collection and delete it from the backlog.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){ _ in
        }
        let ok = UIAlertAction(title: "OK", style: .default){ _ in
            BackEntries.games.remove(at: BackEntries.games.index(of: self.entry!)!)
            let newEntry = CollectionEntry(name: self.entry!.name, system: self.entry!.system, isPlaying: false, progress: "", genre: self.entry!.genre, developer: self.entry!.developer, publisher: self.entry!.publisher, region: self.entry!.region)
            ColEntries.games.append(newEntry)
            self.gameField.text = ""
            self.systemField.text = ""
            self.genreField.text = ""
            self.devField.text = ""
            self.pubField.text = ""
            self.regionField.text = ""
        }
        alertController.addAction(cancel)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
}

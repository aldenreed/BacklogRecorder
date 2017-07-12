//
//  CollectionDetailViewController.swift
//  Final Project
//
//  Created by Alden Reed on 7/6/17.
//  Copyright © 2017 Alden Reed. All rights reserved.
//

import UIKit

class CollectionDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var gameField: UITextField!
    @IBOutlet weak var systemField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var devField: UITextField!
    @IBOutlet weak var pubField: UITextField!
    @IBOutlet weak var regionField: UITextField!
    @IBOutlet weak var isPlayingSwitch: UISwitch!
    @IBOutlet weak var progressField: UITextView!
    var entry: CollectionEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameField.delegate = self
        self.systemField.delegate = self
        self.genreField.delegate = self
        self.devField.delegate = self
        self.pubField.delegate = self
        self.regionField.delegate = self
        self.progressField.delegate = self
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
            self.progressField.text = entry.progress
            self.isPlayingSwitch.isOn = entry.isPlaying
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
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView == self.progressField){
            self.entry?.progress = progressField.text!
        }
    }
    
    @IBAction func switchToggled(_ sender: UISwitch){
        self.entry?.isPlaying = sender.isOn
        if(sender.isOn){
            PlayingEntries.games.append(self.entry!)
        }else{
            PlayingEntries.games.remove(at: PlayingEntries.games.index(of: self.entry!)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

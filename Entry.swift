//
//  Entry.swift
//  Final Project
//
//  Created by Alden Reed on 7/5/17.
//  Copyright © 2017 Alden Reed. All rights reserved.
//

import UIKit
class BacklogEntry: NSObject{
    var name: String
    var system: String
    var genre: String?
    var developer: String?
    var publisher: String?
    var region: String?
    init(name: String, system: String, genre: String?, developer: String?, publisher: String?, region: String?){
        self.name = name
        self.system = system
        self.genre = genre
        self.developer = developer
        self.publisher = publisher
        self.region = region
        super.init()
    }
}
class CollectionEntry: BacklogEntry{
    var isPlaying: Bool
    var progress: String
    init(name: String, system: String, isPlaying: Bool = false, progress: String, genre: String?, developer: String?, publisher: String?, region: String?){
        self.isPlaying = isPlaying
        self.progress = progress
        super.init(name: name, system: system, genre: genre, developer: developer, publisher: publisher, region: region)
    }
}
struct ColEntries{
    static var games:[CollectionEntry] = []
}
struct BackEntries{
    static var games:[BacklogEntry] = []
}
struct PlayingEntries{
    static var games:[CollectionEntry] = []
}

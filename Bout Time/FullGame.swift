//
//  Game.swift
//  Bout Time
//
//  Created by Bradley White on 9/21/17.
//  Copyright © 2017 Bradley White. All rights reserved.
//

import Foundation

class FullGame {
    
    var events: [EventNumber : Event] = [:]
    var round : GameRound = GameRound()
    var correctRounds = 0
    var totalRounds = 0

    func createEventDictionary() throws {
        do {
            let eventDictionary : Dictionary = try PlistConverter.dictionary(fromFile: "Events", ofType: "plist")
            let events = try DictionaryUnarchiver.EventsDictionary(fromDictionary: eventDictionary)
            self.events = events
        } catch PlistError.invalidDictionary {
            throw PlistError.invalidDictionary
        } catch PlistError.invalidEvent {
            throw PlistError.invalidEvent
        } catch PlistError.invalidPath {
            throw PlistError.invalidPath
        }
    }
    
    func newRound() {
        round = GameRound(from: events)
    }
    init() {
        
        do {
            try createEventDictionary()
        } catch {
            
        }
        newRound()
        
    }
    
}

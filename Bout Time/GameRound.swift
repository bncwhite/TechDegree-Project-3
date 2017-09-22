//
//  GameRound.swift
//  Bout Time
//
//  Created by Bradley White on 9/21/17.
//  Copyright © 2017 Bradley White. All rights reserved.
//

import Foundation
import GameKit

class GameRound {
    var events: [Event] = []
    let amountOfEvents = 4
    var randomIndexes: [Int] = []
    
    init(){}
    
    init(from events: [EventNumber : Event]) {
        
        createRandomIndexes(with: events.count)
        
        for number in randomIndexes {
            
            if let eventNumber = EventNumber(rawValue: "event\(number)"), let event = events[eventNumber] {
                self.events.append(event)
            }

        }
    }
    
    func createRandomIndexes(with totalEvents: Int) {
            
        while randomIndexes.count < amountOfEvents {
            let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: totalEvents)
            
            if !randomIndexes.contains(randomNumber) {
                randomIndexes.append(randomNumber)
            }

        }
    }
}

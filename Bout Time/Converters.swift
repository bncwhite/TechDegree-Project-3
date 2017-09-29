//
//  Converters.swift
//  Bout Time
//
//  Created by Bradley White on 9/21/17.
//  Copyright © 2017 Bradley White. All rights reserved.
//

import Foundation

enum PlistError: Error {
    case invalidPath
    case invalidDictionary
    case invalidEvent
}

class PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String : AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistError.invalidPath
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else {
            throw PlistError.invalidDictionary
        }
        return dictionary
    }
}

class DictionaryUnarchiver {
    static func EventsDictionary(fromDictionary dictionary: [String : AnyObject]) throws -> [EventNumber : Event] {
        var events: [EventNumber : Event] = [:]
        
        for (key, value) in dictionary {
            if let eventDictionary = value as? [String : Any], let description = eventDictionary["description"] as? String, let year = eventDictionary["year"] as? Int {
                let event = Event(description: description, year: year)
                guard let eventKey = EventNumber(rawValue: key) else {
                    throw PlistError.invalidEvent
                }
                
                events.updateValue(event, forKey: eventKey)
            }
        }
        return events
    }
}

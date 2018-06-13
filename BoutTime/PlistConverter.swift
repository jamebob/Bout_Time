//
//  PlistConverter.swift
//  BoutTime
//
//  Created by Jamie MacLean on 07/06/2018.
//  Copyright © 2018 Butterstone Studios. All rights reserved.
//

import Foundation

// Enum for Error Handling
enum PlistErrors: String, Error {
    case invalidResource = "Invalid Resource"
    case conversionFailure = "Conversion Failed"
}



// PlistConverter & Unarchiver class
class PlistConverter {
    static func array(fromFile name: String, ofType type: String) throws -> [[String:AnyObject]] {
        guard let plistPath = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistErrors.invalidResource
        }
        guard let array = NSArray(contentsOfFile: plistPath) as? [[String:AnyObject]] else {
            throw PlistErrors.conversionFailure
        }
       return array
    }
}



class EventsUnarchiver {
    static func EventsCollection(fromArray array: [[String:AnyObject]]) throws -> [Event] {
        var events = [Event]()
        
        for event in array {
            if let name = event["Event"] as? String,
                let year = event["Year"] as? Int,
                let url = event["url"] as? String {
                let castedArray = Event(name: name, date: year, URL: url)
                events.append(castedArray)
            } else{
                 throw PlistErrors.conversionFailure
            }
            
        }
        return events
    }
}



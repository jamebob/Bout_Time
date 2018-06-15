//
//  WorldEvent.swift
//  BoutTime
//
//  Created by Jamie MacLean on 07/06/2018.
//  Copyright © 2018 Butterstone Studios. All rights reserved.
//
import Foundation
import GameKit

struct Event {
    let name: String
    let date: Int
    let URL: String
}


class EventCollection{
    var eventsArray = [Event]()
    var currentRoundEvents = [Event]()
   
  

    init() {
    do {
    let eventsList = try PlistConverter.array(fromFile: "WorldEvents", ofType: "plist")
    eventsArray = try EventsUnarchiver.EventsCollection(fromArray: eventsList)
    }
    catch PlistErrors.invalidResource {
    print ("Failed loading Events \(PlistErrors.invalidResource.rawValue)")
    } catch PlistErrors.conversionFailure {
    print ("Plist \(PlistErrors.conversionFailure.rawValue)")
    } catch let error{
        print(error)
        fatalError("\(error)")
        }
    }
   
    
    func randomIndex() -> Int {
        let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: eventsArray.count)
        return randomIndex
    }
    
    
    func newEventSet() {
       
        for _ in 1...4 {
          let eventToShuffle = randomIndex()
            currentRoundEvents.append(eventsArray[eventToShuffle])
            eventsArray.remove(at: eventToShuffle)
        }
       
   
    }
    

    func resetEventset(){
            for i in 0..<currentRoundEvents.count{
                eventsArray.append(currentRoundEvents[i])
            }
        currentRoundEvents = []
      
        
    }
    
 
    
    func sortCurrentEventset() -> [Event]{
       let sortedEvents = currentRoundEvents.sorted(by: {$0.date < $1.date})
        return sortedEvents
        
    }
    
    
    
}


    
    
    


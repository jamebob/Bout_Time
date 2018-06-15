//
//  plistConvert.swift
//  BoutTime
//
//  Created by Jamie MacLean on 14/06/2018.
//  Copyright © 2018 Butterstone Studios. All rights reserved.
//

import Foundation

enum converterErrors :Error {
    case error1
    case error2
}

class Converter {
    
    static func array (fromFile file: String, ofType type: String) throws -> [String] {
        guard let plistPath = Bundle.main.path(forResource: file, ofType: type) else{
           throw converterErrors.error1
        }
  
        guard let array = NSArray(contentsOfFile: plistPath) as? [String] else{
            throw converterErrors.error1
            
        }
        return array
}
    
    
}


class Unarchiver {
    
    static func newArray (fromArray :[String]) -> [String]{
       let var1 = fromArray
        return var1
    }
    
}

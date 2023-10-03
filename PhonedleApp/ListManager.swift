//
//  ListManager.swift
//  PhonedleApp
//
//  Created by Justin Gonzales on 4/14/23.
//

import Foundation

class ListManager {
    
    
    
    func getItems(fromPlistWithName name: String) -> [String]? {
        if let path = Bundle.main.path(forResource: name, ofType: "plist") {
            if let items = NSArray(contentsOfFile: path) as? [String] {
                return items
            }
        }
        return nil
    }
    
    
    
}

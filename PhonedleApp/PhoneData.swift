//
//  PhoneData.swift
//  PhonedleApp
//
//  Created by Justin Gonzales on 4/22/23.
//

import Foundation

struct PhoneData{
    
    static func loadPhoneData() -> [Phones] {
            var phones: [Phones] = []

            guard let plistPath = Bundle.main.path(forResource: "iPhonesList", ofType: "plist") else {
                print("Error: iPhonesList.plist not found")
                return phones
            }

            guard let plistArray = NSArray(contentsOfFile: plistPath) else {
                print("Error: Unable to read contents of iPhonesList.plist")
                return phones
            }

            do {
                let data = try PropertyListSerialization.data(fromPropertyList: plistArray, format: .xml, options: 0)
                phones = try PropertyListDecoder().decode([Phones].self, from: data)
            } catch {
                print("Error decoding plist data: \(error)")
            }

            return phones
        }
    
}

//
//  Phones.swift
//  PhonedleApp
//
//  Created by Justin Gonzales on 4/22/23.
//

import Foundation

struct Phones: Codable, Identifiable {
    var id: String { name }
    var name: String
    var releaseYear: Int
    var processor: String
    var noCameras: Int
    var touchID: Bool
    var faceID: Bool
    var screenSize: Double
    var resolutionHeight: Int
    var resolutionWidth: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case releaseYear = "Release Year"
        case processor = "Processor"
        case noCameras = "Number of Cameras"
        case touchID = "Touch ID"
        case faceID = "Face ID"
        case screenSize = "Screen Size"
        case resolutionHeight = "Resolution Height"
        case resolutionWidth = "Resolution Width"
        
    }
}

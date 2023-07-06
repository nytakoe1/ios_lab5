//
//  CharacterModel.swift
//  lab4
//
//  Created by Яна Павлова on 05.07.2023.
//

import Foundation

struct CharacterLocation : Codable {
    var name : String
    
    enum CodingKeys : String, CodingKey {
        case name
    }
}

struct CharacterModel : Codable {
    
    let id: Int
    let name: String
    let status: String
    var species: String
    let gender: String
    var location: CharacterLocation
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, gender, location, image
    }
    
}

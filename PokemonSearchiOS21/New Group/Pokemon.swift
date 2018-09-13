//
//  Pokemon.swift
//  PokemonSearchiOS21
//
//  Created by Ivan Ramirez on 9/13/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation


struct Pokemon: Decodable {
    
    // name, weight, ID, abilites, Spirits(images)
    
    let name: String
    let weight: Int
    let id: Int
    
    let abilities: [Abilities]
    let sprites: Sprites
    
    // were going to add the following code below to get the array in the porkemonController
    //this is a computed propeirty that will give us back all the abilities 
    var abilitiesName: [String] {
        return abilities.map{$0.ability.name}
    }
    // need to make another sturct bc of the Abilities dictioanry
    
    struct Abilities: Decodable {
        let ability: Ability
        
        //once here we can work with the properites directly
        struct Ability: Decodable {
            let name: String
        }
    }
    
    struct Sprites: Decodable {
        
        let image: URL
        
        // need to use coding keys in order to make the image be appropriet
        //This is a protocol that takes the name of your object property and matches the JSON KEY
        //image is the local name we gave in the top Struct
        private enum CodingKeys: String, CodingKey {
            case image = "front_default"
        }
    }
    
}



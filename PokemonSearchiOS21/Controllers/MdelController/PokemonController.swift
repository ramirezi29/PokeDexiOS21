//
//  PokemonController.swift
//  PokemonSearchiOS21
//
//  Created by Ivan Ramirez on 9/13/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class PokemonController {
    
    
    static let shared = PokemonController()
    
    // we can put pokemon at the end of this URL but we want more practice using appendingPathComponents
    let baseURL = URL(string: "https://pokeapi.co/api/v2")
    
    /*
     -----------------
     fetch Pokemon func
     -----------------
     */
    
    
    // its going to ocmplete with a pokemon
    //the searchTerm: String is what the person types inot the searchbar
    func fetchPokemon(with searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        guard let url = baseURL else {
            fatalError("Bad bsae url")
        }
        //"http://pokeapi.co/api/v2/pokemon/pickachu
        let builtURL = url.appendingPathComponent("pokemon").appendingPathComponent(searchTerm)
        var request = URLRequest(url: builtURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error with data task \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            
            //we unwrap the data that came back from the dataTask
            guard let data = data else { completion(nil); return }
            
            
            do{
                
                //want to get a pokemon back. so we set up a do try catch
                //used JSONDecoder() to decode your object  from the data that came back from the asnch calll
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon)
                
            } catch let error {
                
                print("there was an error with jsonDecoder \(error)\(error.localizedDescription)")
                completion(nil); return
            }
            
            }.resume()
    }
    
    
    /*
     -----------------
     func fetch image\
     this ones using ....dataTask(with: URL, completionHandler: Data...)
     -----------------
     */
    
    // need UIKiet because we're working with images
    // were completing with an image
    func fetchPokemonImage(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        //the url missing field should be our image
        //thise has GET built with it. and Swift 4 can decode URL from strings
        //"data Task, get the data
        URLSession.shared.dataTask(with: pokemon.sprites.image) { (data, _, error) in
            if let error = error {
                print("Error fetching image \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            //data that came back
            guard let data = data else { completion(nil); return }
            
            let image = UIImage(data: data)
            completion(image)
            
            }.resume()
        
    }
    //somewhat similar to completing with an immage
    //func returnPokemon() -> UIImage? {
    //    return UIImage()
    //}
}
























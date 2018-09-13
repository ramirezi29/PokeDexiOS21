//
//  PokemonViewController.swift
//  PokemonSearchiOS21
//
//  Created by Ivan Ramirez on 9/13/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // we dont need to say self.search.delegate = self because we did it in the storyboard
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        PokemonController.shared.fetchPokemon(with: searchTerm.lowercased()) { (pokemon) in
            
            if pokemon != nil {
                // This puts it on the main thread
                print("Are you on dah main thread \(Thread.isMainThread)")
                guard let pokemon = pokemon else { return }
                DispatchQueue.main.async {
                    self.nameLabel.text = pokemon.name
                    self.weightLabel.text = "Weight: \(pokemon.weight) kg"
                    self.idLabel.text = "ID: \(pokemon.id)"
                    self.abilitiesLabel.text = pokemon.abilitiesName.joined(separator: ", ")
                    searchTerm = ""
                }
                PokemonController.shared.fetchPokemonImage(pokemon: pokemon, completion: { (image) in
                    DispatchQueue.main.async {
                        self.spriteImageView.image = image
                    }
                })
                
            } else {
                DispatchQueue.main.async {
                    self.nameLabel.text = "Bad search text"
                }
            }
        }
    }
}

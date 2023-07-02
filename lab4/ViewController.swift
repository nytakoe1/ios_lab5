//
//  ViewController.swift
//  lab4
//
//  Created by Яна Павлова on 26.06.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var CharacterView: UITableView!
    
    private var data : [CharacterData] = [
        CharacterData(id: 2, name: "Morty Smith", status: CharacterData.Status.alive, species: "Human", gender: CharacterData.Gender.male, location: "Citadel of Ricks", image: "rm1.jpeg"),
        CharacterData(id: 11, name: "Albert Einstein", status: CharacterData.Status.dead, species: "Human", gender: CharacterData.Gender.male, location: "Earth (Replacement Dimension)", image: "11"),
        CharacterData(id: 15, name: "Alien Rick", status: CharacterData.Status.unknown, species: "Alien", gender: CharacterData.Gender.male, location: "Citadel of Ricks", image: "15"),
        CharacterData(id: 33, name: "Beebo", status: CharacterData.Status.dead, species: "Alien", gender: CharacterData.Gender.male, location: "Venzenulon 7", image: "33"),
        CharacterData(id: 41, name: "ig Boobed Waitress", status: CharacterData.Status.alive, species: "Mythological Creature", gender: CharacterData.Gender.female, location: "Fantasy World", image: "41"),
        CharacterData(id: 44, name: "Body Guard Morty", status: CharacterData.Status.dead, species: "Human", gender: CharacterData.Gender.male, location: "Citadel of Ricks", image: "44"),
        CharacterData(id: 47, name: "Birdperson", status: CharacterData.Status.alive, species: "Alien", gender: CharacterData.Gender.male, location: "Planet Squanch", image: "47.jpeg"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CharacterView.delegate = self
        CharacterView.dataSource = self
        CharacterView.backgroundColor = .clear
        CharacterView.separatorColor = .white
    }
    //MARK: - tableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let characterInfoView = storyboard?.instantiateViewController(identifier: "characterInfoViewController") as? characterInfoViewController else {return }
        characterInfoView.delegate = self
        present(characterInfoView, animated: true)
        characterInfoView.data = data[indexPath.row]
    }
    
    //MARK: - tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "Character") as? Character else {return UITableViewCell()}
        let dataCell = data[indexPath.row]
        characterCell.setUpData(character: dataCell)
        

        return characterCell
    }


}

extension ViewController : characterInfoViewControllerDelegate{
    
    func changeLocation(with id: Int, and newLocation: String) {
        if let index = data.firstIndex(where: {$0.id == id}){
            data[index].location = newLocation
            CharacterView.reloadData()
        }
    }
    
    func changeSpicices(with id: Int, and newSpicies: String) {
        if let index = data.firstIndex(where: {$0.id == id}){
            data[index].species = newSpicies
            CharacterView.reloadData()
        }
    }
    
    
    

    
    
}

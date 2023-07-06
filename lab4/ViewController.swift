//
//  ViewController.swift
//  lab4
//
//  Created by Яна Павлова on 26.06.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var CharacterView: UITableView!
    
    private var characters : [CharacterModel] = []
    private let networkManager: NetworkManager = NetworkManager()
    

    private func loadCharacter(byId: Int) {
        networkManager.fetchCharacter(characterID : byId, completion: { [weak self]
            result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let characterResponse):
                weakSelf.characters.append(characterResponse)
                weakSelf.CharacterView.reloadData()
            case let .failure(error):
                print(error)
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CharacterView.delegate = self
        CharacterView.dataSource = self
        CharacterView.backgroundColor = .clear
        CharacterView.separatorColor = .white
        
        for currentID in 1 ... 20{
            loadCharacter(byId: currentID)
        }
    }
    //MARK: - tableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let characterInfoView = storyboard?.instantiateViewController(identifier: "characterInfoViewController") as? characterInfoViewController else {return }
        characterInfoView.delegate = self
        present(characterInfoView, animated: true)
        characterInfoView.data = characters[indexPath.row]
    }
    
    //MARK: - tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "Character") as? Character else {return UITableViewCell()}
        let dataCell = characters[indexPath.row]
        characterCell.setUpData(character: dataCell)
        

        return characterCell
    }


}

extension ViewController : characterInfoViewControllerDelegate{
    
    func changeLocation(with id: Int, and newLocation: String) {
        if let index = characters.firstIndex(where: {$0.id == id}){
            characters[index].location.name = newLocation
            CharacterView.reloadData()
        }
    }
    
    func changeSpicices(with id: Int, and newSpicies: String) {
        if let index = characters.firstIndex(where: {$0.id == id}){
            characters[index].species = newSpicies
            CharacterView.reloadData()
        }
    }
}

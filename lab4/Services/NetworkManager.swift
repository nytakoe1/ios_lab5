//
//  NetworkManager.swift
//  lab4
//
//  Created by Яна Павлова on 04.07.2023.
//

import Moya
import Foundation

protocol Networkable {
    var provider : MoyaProvider<APITarget> {get}
    func fetchCharacter (characterID : Int, completion : @escaping (Result<CharacterModel, Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<APITarget>(plugins: [NetworkLoggerPlugin()])
    
    func fetchCharacter(characterID: Int, completion: @escaping (Result<CharacterModel, Error>) -> ()) {
        
        request(target: .getCharacter(characterID: characterID), completion: completion)
    }
}

private extension NetworkManager {
    func request<T:Decodable>(target: APITarget, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    print(response)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}



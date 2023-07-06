//
//  APItarget.swift
//  lab4
//
//  Created by Яна Павлова on 04.07.2023.
//

import Moya
import Foundation

enum APITarget{
    case getCharacter(characterID : Int)
}

extension APITarget: TargetType{
    var baseURL : URL{
        guard let url = URL(string : "https://rickandmortyapi.com") else{
            fatalError("no access to API")
        }
        return url
    }
    
    var path: String{
        switch self{
        case .getCharacter(let characterID):
            return "/api/character/" + String(characterID)
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestParameters(parameters: [:] , encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json" ]
    }
  
}




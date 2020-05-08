//
//  PetitionManager.swift
//  Project7
//
//  Created by Mark Patrick Perdon on 5/7/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import Foundation

protocol PetitionsDelgate{
    func didGetPetitions(_ petitionManager: PetitionManager, _ petitions: PetitionsData?)
    func didFailWithError(_ error: Error)
}

struct PetitionManager{
    var petitionsDelegate: PetitionsDelgate?
    var urlString = String()
    
    func fetchPetitions(){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlResponse, err) in
                if let err = err{
                    self.petitionsDelegate?.didFailWithError(err)
                }
                if let validData = data{
                    if let petitions = self.parseJSON(in: validData){
                        DispatchQueue.main.async {
                            self.petitionsDelegate?.didGetPetitions(self, petitions)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(in data: Data) -> PetitionsData?{
        let decoder = JSONDecoder()
        do{
            let jsonPetitions = try decoder.decode(PetitionsData.self, from: data)
            return jsonPetitions
            
        }catch{
            petitionsDelegate?.didFailWithError(error)
            return nil
        }
    }
}

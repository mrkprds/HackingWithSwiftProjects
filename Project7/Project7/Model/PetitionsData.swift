//
//  petition.swift
//  Project7
//
//  Created by Mark Patrick Perdon on 4/4/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import Foundation

struct PetitionsData: Codable{
    var results: [PetitionData]

    struct PetitionData: Codable{
        var title: String
        var body: String
        var signatureCount: Int
    }
}






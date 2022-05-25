//
//  Produce.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import Foundation
import SwiftUI

class Produce: CustomDebugStringConvertible, Codable{
    var debugDescription: String {
        return "Produce(name: \(self.name), description: \(self.description))"
    }
    
    var name: String
    var description: String
    var imageUrl: String
    var season: String

    var inKitchen: Bool = false


    private enum CodingKeys: String, CodingKey {
        case name, description, imageUrl, season
    }
    
    init(named name: String, description: String, imageUrl: String, season: String) {
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.season = season
    }
}

struct ProduceResult: Codable {
    let produces: [Produce]
}

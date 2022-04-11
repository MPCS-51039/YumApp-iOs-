//
//  Produce.swift
//  GoodProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import Foundation

class Produce {
    var name: String
    var description: String
    var confirmedEaten: Bool = false
    
    init(named name: String, description: String) {
        self.name = name
        self.description = description
    }
    
}

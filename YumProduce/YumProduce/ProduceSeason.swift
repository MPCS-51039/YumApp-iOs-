//
//  Category.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 5/10/22.
//

import Foundation
import SwiftUI

struct ProduceSeason: Decodable {
    let id, name, image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}

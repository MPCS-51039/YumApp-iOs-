//
//  Category.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 5/10/22.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable {
    
    case neverEaten
    case pendingEaten
    case haveEaten
}


extension Category: Identifiable {
    var id: String { rawValue }
}

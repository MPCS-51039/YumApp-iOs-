//
//  File.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 5/24/22.
//

import Foundation

class ProduceData {
    static let instance = ProduceData()
    var produces: [Produce] = []
    var shouldReloadIndex: Bool = false
}

//
//  Car.swift
//  InstaCar
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import Foundation

struct Car: Decodable {
    let name: String
    let price: Float
    let modelYear: Date
    let brand: String
    let imageName: String
    var rate: Double
}


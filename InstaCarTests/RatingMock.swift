//
//  RatingMock.swift
//  InstaCarTests
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import Foundation
@testable import InstaCar

class RatingMock: RatingDelegate {
    
    var didRate: Bool = false
    var value : Double = 0.0
    var row: Int = 0
    
    func rate(_ value: Double, row: Int) {
        self.value = value
        self.row = row
        didRate = true
    }
    
}

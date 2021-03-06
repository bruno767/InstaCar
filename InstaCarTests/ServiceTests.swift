//
//  ServiceTests.swift
//  InstaCarTests
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import XCTest
@testable import InstaCar

class ServiceTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testService() {
        let carViewModel = Service.shared.fetchCars(url: "jsonTest", classRef: ServiceTests.self)[1]
        
        XCTAssertEqual(carViewModel.name, "testCar")
        XCTAssertNotNil(carViewModel.brandImage)
        XCTAssertNotNil(carViewModel.carImage)
        XCTAssertEqual(carViewModel.modelYear, "Jun/2010")
        XCTAssertEqual(carViewModel.priceAndModel, "F. Registration: Jun/2010 Price: 500,00 €")
        XCTAssertEqual(carViewModel.currentRate, 3.0)
    }

    func testListOrder() {
        let carViewModels = Service.shared.fetchCars(url: "jsonTest", classRef: ServiceTests.self)
        
        XCTAssertGreaterThan(carViewModels[0].currentRate, carViewModels[1].currentRate)
        
    }
}

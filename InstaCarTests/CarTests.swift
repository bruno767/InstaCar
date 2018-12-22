//
//  CarTests.swift
//  InstaCarTests
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import XCTest
@testable import InstaCar

class CarTests: XCTestCase {
    
    var car: Car!
    var carDecoded: Car!
    
    var dateFormatter: DateFormatter!
    let modelYear = "2017-06-19T18:43:19Z"
    let modelYearDecodedCar = "2010-06-19T18:43:19Z"
    
    override func setUp() {
        self.dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let modelYearDate = dateFormatter.date(from: self.modelYear) ?? Date()
        
        self.car = Car(name: "Beetle", price: 10000, modelYear: modelYearDate , brand: "Volkswagen", imageName: "someBrand")
        
        
        if let path = Bundle(for: CarTests.self).path(forResource: "jsonTest", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                self.carDecoded = try decoder.decode([Car].self, from: jsonData)[0]
            } catch {
                return XCTFail("Error: " + error.localizedDescription)
            }
        }else{
            return XCTFail("Did not find the file")
        }
    }
    
    
    override func tearDown() {
        self.car = nil
    }
    
    func testCarModel() {
        
        XCTAssertEqual(car.name, "Beetle")
        XCTAssertEqual(car.modelYear, self.dateFormatter.date(from: self.modelYear))
        XCTAssertEqual(car.imageName,  "someBrand")
        XCTAssertEqual(car.brand, "Volkswagen")
        XCTAssertEqual(car.price, 10000)
    }
    
    func testCarDecodedModel() {
        if carDecoded != nil {
            XCTAssertEqual(carDecoded.name, "testCar")
            XCTAssertEqual(carDecoded.modelYear, self.dateFormatter.date(from: self.modelYearDecodedCar))
            XCTAssertEqual(carDecoded.imageName,  "default")
            XCTAssertEqual(carDecoded.brand, "default")
            XCTAssertEqual(carDecoded.price, 500)
        }else{
            return XCTFail("Could not decode car")
        }
    }
    
}

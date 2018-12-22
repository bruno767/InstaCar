//
//  CarViewModelTests.swift
//  InstaCarTests
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import XCTest
@testable import InstaCar

class CarViewModelTests: XCTestCase {
    var car: Car!
    var carViewModel: CarViewModel!
    
    var carDefaultValue: Car!
    var carViewModelDefaultValue: CarViewModel!
    
    let modelYear = "2017-06-19T18:43:19Z"
    var dateFormatter = DateFormatter()
    
    override func setUp() {
        self.dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let modelYearDate = dateFormatter.date(from: self.modelYear) else{
            return XCTFail("Could not format the year")
        }
        
        self.car = Car(name: "Beetle", price: 10000, modelYear: modelYearDate , brand: "default", imageName: "default")
        self.carViewModel = CarViewModel(car: car)
        
        self.carDefaultValue = Car(name: "SomeName", price: 1, modelYear: Date(), brand: "someBrand", imageName: "someImage")
        
        self.carViewModelDefaultValue = CarViewModel(car: carDefaultValue)
    }
    
    override func tearDown() {
        self.car = nil
        self.carViewModel = nil
    }
    
    func testCarViewModel() {
        XCTAssertEqual(carViewModel.name, car.name)
        XCTAssertNotNil(carViewModel.brandImage)
        XCTAssertNotNil(carViewModel.carImage)
        XCTAssertEqual(carViewModel.modelYear, "Jun/2017")
        XCTAssertEqual(carViewModel.priceAndModel, "F. Registration: Jun/2017 Price: 10.000,00 €")
        XCTAssertEqual(carViewModel.rating, 0.0)
    }
    
    func testCarViewModelNil() {
        XCTAssertEqual(carViewModelDefaultValue.name, carDefaultValue.name)
        XCTAssertNotNil(carViewModelDefaultValue.brandImage)
        XCTAssertNotNil(carViewModelDefaultValue.carImage)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM/yyyy"
        let newDate = dateFormatter.string(from: carDefaultValue.modelYear)
        XCTAssertEqual(carViewModelDefaultValue.modelYear, newDate)
        
        XCTAssertEqual(carViewModelDefaultValue.priceAndModel, "F. Registration: Dec/2018 Price: 1,00 €")
        XCTAssertEqual(carViewModelDefaultValue.rating, 0.0)
    }
    
}

//
//  RatingDelegateTests.swift
//  InstaCarTests
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import XCTest
@testable import InstaCar

class RatingDelegateTests: XCTestCase {

    weak var delegate: RatingDelegate?

    var mockObject: RatingMock?
    
    override func setUp() {
        mockObject = RatingMock()
        self.delegate = mockObject
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDelegate() {
        XCTAssertEqual(mockObject?.didRate, false)
        XCTAssertEqual(mockObject?.row, 0)
        XCTAssertEqual(mockObject?.value, 0.0)

        delegate?.rate(5.0, row: 4)
        
        XCTAssertEqual(mockObject?.didRate, true)
        XCTAssertEqual(mockObject?.row, 4)
        XCTAssertEqual(mockObject?.value, 5.0)

    }


}

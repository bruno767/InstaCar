//
//  CarDataSource.swift
//  InstaCarTests
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import XCTest
@testable import InstaCar

class CarViewControllerTests: XCTestCase {

    var dataSource : [CarViewModel]!
    
    var carViewController: CarViewController!
    var window: UIWindow!
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        carViewController = CarViewController(style: .plain)
        UIApplication.shared.keyWindow!.rootViewController = carViewController
        loadView()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func loadView()
    {
        window.rootViewController = carViewController
        RunLoop.current.run(until: Date())
    }
    
    func testShouldFetchCarViewModels()
    {
        XCTAssertNotNil(carViewController.view, "CarViewController should have been loaded")
        carViewController.fetchData()
        XCTAssertNotNil(carViewController.listOfCarViewModels, "Should fetch bus numbers when the view is loaded")
    }
    
    func testControllerHasTableView() {
        carViewController.loadViewIfNeeded()
        XCTAssertNotNil(carViewController.tableView,
                        "Controller should have a tableview")
    }
    
    func testListOfCars() {
        carViewController.loadViewIfNeeded()
        XCTAssertEqual(carViewController.listOfCarViewModels.count, 10)
        
    }
}
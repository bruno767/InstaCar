//
//  Service.swift
//  InstaCar
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    //To be tested
    func fetchCars (url: String, classRef: AnyClass) -> [CarViewModel] {
        if let path =  Bundle(for: classRef).path(forResource: url, ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let listOfCars = try decoder.decode([Car].self, from: jsonData)
                let sortedList = listOfCars.sorted(by: { $0.rate > $1.rate })
                return sortedList.map({return CarViewModel(car: $0)})
            } catch {
                print("error: ", error)
            }
        }else{
            print ("didint find the file")
        }
        return []
    }
}

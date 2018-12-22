//
//  CarViewModel.swift
//  InstaCar
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit
import Foundation

class CarViewModel {
    
    private var car: Car
    
    var ball = 0
    
    public init(car: Car) {
        self.car = car
    }
    
    public var name: String {
        return car.name
    }
    
    func rating(value: Double) {
        car.rate = (car.rate + value) / 2
    }
    
    public var currentRate: Double {
        return car.rate
    }
    
    public var modelYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM/yyyy"
        let newDate = dateFormatter.string(from: car.modelYear)
        return newDate
    }
    
    public var priceAndModel: String {
        var result = "F. Registration: " + self.modelYear
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "de_DE")
        formatter.numberStyle = .currency
        if let formattedPriceAmount = formatter.string(from: car.price as NSNumber) {
            result += " Price: " + formattedPriceAmount
        }
        return result
    }
    
    public var carImage: UIImage? {
        return UIImage(named: car.imageName) ?? UIImage(named: "default_logo")
    }
    
    public var brandImage: UIImage? {
        if let img = UIImage(named: car.brand.lowercased() + "_logo"){
            return img
        }else{
            return UIImage(named: "default_logo")
        }
    }
}

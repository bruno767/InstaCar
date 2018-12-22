//
//  CarViewCell.swift
//  InstaCar
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit
import Cosmos

class CarViewCell: UITableViewCell {
    
    var carViewModel: CarViewModel!{
        didSet{
            carImageView.image = carViewModel.carImage
            titleLabel.text = carViewModel.name
            subtitleLabel.text = carViewModel.priceAndModel
            brandImageView.image = carViewModel.brandImage
            ratingView.text = carViewModel.rating.description
        }
    }
    
    let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    let ratingView: CosmosView = {
        let rating = CosmosView()
        rating.text = "0.0"
        rating.settings.textMargin = 8
        rating.settings.textColor = UIColor.rgb(r: 7, g: 71, b: 89)
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        
        return rating
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        addSubview(carImageView)
        addSubview(separatorView)
        addSubview(brandImageView)
        addSubview(titleLabel)
        addSubview(ratingView)
        addSubview(subtitleLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: carImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: brandImageView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-10-[v2(1)]|", views: carImageView, brandImageView, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: carImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: brandImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: ratingView, attribute: .left, multiplier: 1, constant: 5))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: ratingView, attribute: .top, relatedBy: .equal, toItem: carImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: ratingView, attribute: .right, relatedBy: .equal, toItem: carImageView, attribute: .right, multiplier: 1, constant: -10))
        //height constraint
        addConstraint(NSLayoutConstraint(item: ratingView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 5))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .left, relatedBy: .equal, toItem: brandImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .right, relatedBy: .equal, toItem: carImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


//
//  CarViewCell.swift
//  InstaCar
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

class CarViewCell: UITableViewCell {
    var carViewModel: CarViewModel!{
        didSet{

            textLabel?.text = carViewModel.name
            detailTextLabel?.text = carViewModel.priceAndModel

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

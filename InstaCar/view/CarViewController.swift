//
//  CarViewController.swift
//  InstaCar
//
//  Created by Bruno Alves on 22.12.18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//
import UIKit
import Foundation

class CarViewController: UITableViewController {
    
    weak var randomTimer: Timer?
    var listOfCarViewModels = [CarViewModel]()
    let cellId = "carCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        fetchData()
        randomTimer = nil
    }
    
    func fetchData() {
        self.listOfCarViewModels = Service.shared.fetchCars(url: "jsonData", classRef: CarViewController.self);
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCarViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CarViewCell
        cell.carViewModel = listOfCarViewModels[indexPath.row]
        cell.ratingView.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    fileprivate func setupTableView() {
        tableView.register(CarViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.allowsSelection = false
        tableView.separatorColor = .mainTextBlue
        tableView.backgroundColor = UIColor.rgb(r: 38, g: 38, b: 38)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "InstaCar"
        
        let randomButton = UIButton(type: .system)
        let img = #imageLiteral(resourceName: "dice").withRenderingMode(.alwaysOriginal)
        randomButton.setImage(img, for: .normal)
        randomButton.imageView?.contentMode = .scaleAspectFit
        randomButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        randomButton.addTarget(self, action: #selector(radomRating), for: .touchDown)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: randomButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .yellow
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 30, g: 45, b: 134)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}
//MARK: Random timer

extension CarViewController {
    @objc
    func radomRating() {
        if randomTimer == nil {
            randomTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        } else {
            randomTimer?.invalidate()
            randomTimer = nil
        }
    }

    @objc
    func runTimedCode(){
        let count = self.listOfCarViewModels.count - 1
        let row = Int.random(in: 0 ... count)
        let rateValue = Double.random(in: 1 ... 5)
        self.rate(rateValue, row: row)
    }
}

//MARK: Delegate

extension CarViewController: RatingDelegate {
    func rate(_ value: Double, row: Int) {
        
        let car  = self.listOfCarViewModels[row]
        car.rating(value: value)

        showToast(message: "Rating the " + car.name + " with " + String(format: "%.1f", value) + " stars.")
       
        let indexPath = IndexPath(item: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

//MARK: Setting up Nav Controller

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return .lightContent
    }
}

extension UIColor {
    static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89)
    static let highlightColor = UIColor.rgb(r: 50, g: 199, b: 242)
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

//MARK: Setting up Toast
extension UITableViewController {
    func showToast(message : String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        if presentedViewController == nil {
            self.present(alert, animated: true, completion: nil)
        }
        
        let when = DispatchTime.now() + 2.5
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
        }
        
    }
}

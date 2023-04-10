//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
    }
    
    
    // MARK: - Class Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The TextField delegate is this class.
        searchTextField.delegate = self
    }
    
    
    // MARK: - UI Text Field Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        return true
    }
    
}


//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import UIKit

final class WelcomeViewController: UIViewController, DecodeLaureat {
    //MARK: - Properties
    private let textBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    private let latitudeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(for: .title2, weight: .regular)
        textField.tag = 0
        textField.adjustsFontForContentSizeCategory = true
        textField.borderStyle = .roundedRect
        textField.textColor = .label
        textField.placeholder = "Latitude"
        return textField
    }()
    private let longitudeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(for: .title2, weight: .regular)
        textField.tag = 1
        textField.adjustsFontForContentSizeCategory = true
        textField.borderStyle = .roundedRect
        textField.textColor = .label
        textField.placeholder = "Longitude"
        return textField
    }()
    private let yearTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(for: .title2, weight: .regular)
        textField.tag = 2
        textField.adjustsFontForContentSizeCategory = true
        textField.borderStyle = .roundedRect
        textField.textColor = .label
        textField.placeholder = "Year, ex. 2020"
        
        return textField
    }()
    typealias Element = Laureate
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(searchBarTapped))
    }
    
    /// When the navigation bar is tapped, check the text fields are not empty, add the user entered data as a 'Laureate' value and perform the search
    @objc func searchBarTapped() {
        if latitudeTextField.text != "", longitudeTextField.text != "" && yearTextField.text != "" {
            validateTextFieldData()
            let latitude = Double(latitudeTextField.text!)
            let longitude = Double(longitudeTextField.text!)
            let year = yearTextField.text!
            
            let userEnteredData = Laureate(id: 9999, category: "", died: "", diedcity: "", borncity: "", born: "", surname: "", firstname: "", motivation: "", location: ["lat" : latitude!, "lng" : longitude!], city: "", borncountry: "", year: year, diedcountry: "", country: "", gender: "", name: "", weight: nil)
            
            let nobelVC = LaureatesViewController()
            nobelVC.userEnteredData = userEnteredData
            navigationController?.pushViewController(nobelVC, animated: true)
        }
        else {
            print("Text Fields Are Empty!!")
            //Alert User text field(s) are empty
        }
    }
    
    /// TO-DO: Implement text field validation to confirm the latitude, longitude, and year values are formatted correctly.
    func validateTextFieldData() {
        ///Would write a function to validate that the numbers entered are correct
        ///Lat/Long values & the year was correct as well.
    }
    
    private func searchLaureates() {
        
    }
    
    //MARK: -
    private func layoutView() {
        view.addSubview(stackView)
        stackView.insertSubview(textBackground, at: 0)
        stackView.addArrangedSubview(latitudeTextField)
        stackView.addArrangedSubview(longitudeTextField)
        stackView.addArrangedSubview(yearTextField)
        
        NSLayoutConstraint.activate([
            latitudeTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            latitudeTextField.heightAnchor.constraint(equalToConstant: 60),
            longitudeTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            longitudeTextField.heightAnchor.constraint(equalToConstant: 60),
            yearTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            yearTextField.heightAnchor.constraint(equalToConstant: 60),
            
            textBackground.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textBackground.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            textBackground.topAnchor.constraint(equalTo: stackView.topAnchor),
            textBackground.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    
    
}

extension WelcomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

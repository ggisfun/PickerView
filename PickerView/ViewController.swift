//
//  ViewController.swift
//  PickerView
//
//  Created by Adam Chen on 2024/10/4.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carTextField: UITextField!
    @IBOutlet var carPickerView: UIPickerView!
    @IBOutlet var carToolbar: UIToolbar!
    
    var selectedCar: Car = cars[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bgImageView = UIImageView(image: UIImage(named: "background"))
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.frame = view.bounds
        view.insertSubview(bgImageView, at: 0)
        
        carTextField.isHidden = true
        carTextField.inputView = carPickerView
        carTextField.inputAccessoryView = carToolbar
        
        carImageView.layer.cornerRadius = 10
        carImageView.image = UIImage(named: cars[0].model[0])
        
        carLabel.layer.cornerRadius = 10
        carLabel.clipsToBounds = true
        carLabel.text = cars[0].brand + " " + cars[0].model[0]
        
        carToolbar.layer.cornerRadius = 10
        carToolbar.clipsToBounds = true
        carToolbar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func selectCar(_ sender: Any) {
        carTextField.becomeFirstResponder()
    }
    
    @IBAction func selectCarCancel(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func selectCarDone(_ sender: Any) {
        let selectedBrand = carPickerView.selectedRow(inComponent: 0)
        let selectedModel = carPickerView.selectedRow(inComponent: 1)
        carLabel.text = cars[selectedBrand].brand + " " + cars[selectedBrand].model[selectedModel]
        carImageView.image = UIImage(named: cars[selectedBrand].model[selectedModel])
        view.endEditing(true)
    }

}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return cars.count
        } else {
            return selectedCar.model.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return cars[row].brand
        } else {
            return selectedCar.model[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedCar = cars[row]
            carPickerView.reloadComponent(1)
            carPickerView.selectRow(0, inComponent: 1, animated: true)
        }
    }
}


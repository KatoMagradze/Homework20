//
//  DurationFilterViewController.swift
//  Homework20
//
//  Created by Kato on 5/13/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class DurationFilterViewController: UIViewController {

    var maxPickerData = [String]()
    var selectedMaxPicker = 0
    
    @IBOutlet weak var maxDurationPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maxDurationPicker.delegate = self
        maxDurationPicker.dataSource = self
        // Do any additional setup after loading the view.
        
        for i in 1...60 {
            maxPickerData.append(String(i))
        }
    }
    

    @IBAction func onFilterTapped(_ sender: UIButton) {
        
        if let firstViewController = self.navigationController?.viewControllers.first {
            let vc = firstViewController as! ViewController
            vc.filterValue = selectedMaxPicker
            self.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
}

extension DurationFilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return maxPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedMaxPicker = row
    }
    
    
}

//
//  PickerViewContainer.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation
import UIKit

class PickerViewContainer: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    var config: PickerViewConfig
    let pickerView: UIPickerView
    
    init(_ config: PickerViewConfig, _ pickerView: UIPickerView) {
        self.config = config
        self.pickerView = pickerView
        super.init()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.pickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.config.options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.config.options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard (self.config.options.count >= 1) else {
            return
        }
        self.config.function(config.options[row])
    }
    
    func setOptions(options: [String]) {
        self.config.options = options
        self.pickerView.reloadAllComponents()
    }
    
}

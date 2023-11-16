//
//  PickerViewContainer.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/15/23.
//

import Foundation
import UIKit

class PickerViewContainer<T>: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    var config: PickerViewConfig<T>
    let pickerView: UIPickerView
    
    init(_ config: PickerViewConfig<T>, _ pickerView: UIPickerView) {
        self.config = config
        self.pickerView = pickerView
        super.init()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.pickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return 1
        }
        return self.config.options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return self.config.label
        }
        return self.config.options[row].label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            return
        }
        guard (self.config.options.count >= 1) else {
            return
        }
        self.config.function(config.options[row].value)
    }
    
    
    func setOptions(options: [PickerViewOptionConfig<T>]) {
        self.config.options = options
        self.pickerView.reloadAllComponents()
    }
    
}

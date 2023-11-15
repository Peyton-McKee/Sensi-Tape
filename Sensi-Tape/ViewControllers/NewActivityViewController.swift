//
//  NewActivityViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/14/23.
//

import UIKit

class NewActivityViewController: UIViewController, ErrorHandler {
    @IBOutlet var headerView: HeaderView!
    @IBOutlet var activityTitleTextField: UITextField!
    @IBOutlet var activityTypePickerView: UIPickerView!
    
    @IBOutlet var timePickerView: UIPickerView!
    @IBOutlet var durationPickerView: UIPickerView!
    @IBOutlet var milesPickerView: UIPickerView!
    
    var selectedTitle: String?
    var selectedType: String?
    var selectedTime: Int?
    var selectedDuration: Int?
    var selectedDistance: Float?
    
    lazy var activityTypePickerViewContainer = PickerViewContainer(PickerViewConfig(function: self.selectType), self.activityTypePickerView)
    
    lazy var timePickerViewContainer = PickerViewContainer(PickerViewConfig(function: self.selectTime), self.timePickerView)
    lazy var durationPickerViewContainer = PickerViewContainer(PickerViewConfig(function: self.selectDuration), self.durationPickerView)
    lazy var milesPickerViewContainer = PickerViewContainer(PickerViewConfig(function: self.selectDistance), self.milesPickerView)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timePickerViewContainer.setOptions(options: [])
        self.activityTypePickerViewContainer.setOptions(options: [])
        self.durationPickerViewContainer.setOptions(options: [])
        self.milesPickerViewContainer.setOptions(options: [])
        self.queryActivityTypes()
        
        // Do any additional setup after loading the view.
    }
    
    private func selectTitle(_ title: String) {
        self.selectedTitle = title
    }
    
    private func selectType(_ type: String) {
        self.selectedType = type
    }
    
    private func selectTime(_ time: String) {
        self.selectedTime = Int(time)
    }
    
    private func selectDuration(_ duration: String) {
        self.selectedDuration = Int(duration)
    }
    
    private func selectDistance(_ distance: String) {
        self.selectedDistance = Float(distance)
    }
    
    private func queryActivityTypes() {
        APIHandler.shared.queryData(route: Route.activityTypes(), completion: {
            result in
            do {
                let types : ActivityTypes = try result.get()
                DispatchQueue.main.async {
                    self.activityTypePickerViewContainer.setOptions(options: types.activityTypes)
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
        })
    }
    
    private func submitData() {
        
    }
}

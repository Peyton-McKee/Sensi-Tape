//
//  NewActivityViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/14/23.
//

import UIKit

class NewActivityViewController: UIViewController, ErrorHandler, AlertHandler {
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
    var selectedDistance: Int?
    
    var currentUser: AuthenticatedUser?

    lazy var activityTypePickerViewContainer = PickerViewContainer(PickerViewConfig(label: "Type*", function: self.selectType), self.activityTypePickerView)
    
    lazy var timePickerViewContainer = PickerViewContainer(PickerViewConfig(label: "Time*", function: self.selectTime), self.timePickerView)
    lazy var durationPickerViewContainer = PickerViewContainer(PickerViewConfig(label: "Duration*", function: self.selectDuration), self.durationPickerView)
    lazy var milesPickerViewContainer = PickerViewContainer(PickerViewConfig(label: "# of Miles*", function: self.selectDistance), self.milesPickerView)
    
    let numberMilesOptions: [PickerViewOptionConfig] = [PickerViewOptionConfig(label: "< 1", value: 2520), PickerViewOptionConfig(label: "1 - 3", value: 5280 * 2), PickerViewOptionConfig(label: " 3 - 5", value: 5280 * 4), PickerViewOptionConfig(label: "5+", value: 5280 * 5)]
    lazy var secondTimeOptions: [PickerViewOptionConfig] = (0..<3600 * 24).map({PickerViewOptionConfig(label: self.getTimeLabel($0), value: $0)})
    lazy var timeOptions = self.secondTimeOptions.enumerated().filter({$0.offset % 900 == 0}).map({$0.element})
    
    let secondDurationOptions : [PickerViewOptionConfig] = (0..<3600 * 24).map({PickerViewOptionConfig(label: "\($0/3600) hr, \($0%3600/60) mins", value: $0)})
    
    lazy var durationOptions = self.secondDurationOptions.enumerated().filter({$0.offset % 900 == 0}).map({$0.element})
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timePickerViewContainer.setOptions(options: self.timeOptions)
        self.activityTypePickerViewContainer.setOptions(options: [])
        self.durationPickerViewContainer.setOptions(options: self.durationOptions)
        self.milesPickerViewContainer.setOptions(options: self.numberMilesOptions)
        self.activityTitleTextField.delegate = self
        self.queryActivityTypes()
        do {
            self.currentUser = try Model.shared.getCurrentUser()
        } catch {
            self.handle(error: error)
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func selectTitle(_ title: String?) {
        self.selectedTitle = title
    }
    
    private func selectType(_ type: String) {
        self.selectedType = type
    }
    
    private func selectTime(_ time: Int) {
        self.selectedTime = time
    }
    
    private func selectDuration(_ duration: Int) {
        self.selectedDuration = duration
    }
    
    private func selectDistance(_ distance: Int) {
        self.selectedDistance = distance
    }
    
    private func getTimeLabel(_ secs: Int) -> String {
        let hour = secs/3600
        let min = secs%3600/60
        let isMidnight = hour == 0
        let isNoon = hour == 12
        let isAfternoon = hour >= 12
        return "\(isMidnight ? 12 : isAfternoon && !isNoon ? hour - 12 : hour):\(min) \(isAfternoon ? "pm" : "am")"
    }
    
    private func queryActivityTypes() {
        APIHandler.shared.queryData(route: Route.activityTypes(), completion: {
            result in
            do {
                let types : ActivityTypes = try result.get()
                DispatchQueue.main.async {
                    self.activityTypePickerViewContainer.setOptions(options: types.activityTypes.map({PickerViewOptionConfig(label: $0, value: $0)}))
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
        })
    }
    
    @IBAction func submitData() {
        print(self.selectedTitle, self.selectedType, self.selectedTime, self.selectedDuration, self.selectedDistance)
        guard let title = self.selectedTitle, let type = self.selectedType, let time = self.selectedTime, let duration = self.selectedDuration, let distance = self.selectedDistance else {
            self.handle(error: ConfigurationError.didNotFillOutAllRequiredFields)
            return
        }
        APIHandler.shared.mutateData(route: Route.createActivityType(userId: self.currentUser!.id), data: CreateActivityPayload(title: title, type: type, time: time, duration: duration, distance: distance), completion: {
            result in
            do {
                let successMessage = try result.get()
                DispatchQueue.main.async {
                    self.alert(successMessage)
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
        })
    }
}


extension NewActivityViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.selectTitle(textField.text)
    }
}

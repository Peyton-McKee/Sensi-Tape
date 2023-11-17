//
//  DataViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 11/14/23.
//

import UIKit

class DataViewController: UIViewController, ErrorHandler {
    @IBOutlet var headerView: HeaderView!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var activityDescriptionLabel: UILabel!
    
    @IBOutlet var activitySelectorPickerView: UIPickerView!
    @IBOutlet var frontAnkleLineGraph: LineGraphView!
    @IBOutlet var leftSideAnkleLineGraph: LineGraphView!
    @IBOutlet var rightSideAnkleLineGraph: LineGraphView!
    
    var selectedActivity: Activity?
    var currentUser: AuthenticatedUser?
    
    var activities: [Activity] = []
    
    lazy var activitySelectorViewPickerViewContainer = PickerViewContainer(PickerViewConfig(label: "Select Activity", function: self.setSelectedActivityType), self.activitySelectorPickerView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iconImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            let currentUser = try Model.shared.getCurrentUser()
            self.currentUser = currentUser
            if (self.selectedActivity == nil) {
                self.configreFrontAnkleLineGrpah(data: currentUser.data)
                self.configureLeftSideAnkleLineGraph(data: currentUser.data)
                self.configureRightSideAnkleLineGraph(data: currentUser.data)
            }
            self.activities = currentUser.activities
            self.activitySelectorViewPickerViewContainer.setOptions(options: currentUser.activities.map({PickerViewOptionConfig(label: $0.name, value: $0.id)}))
        } catch {
            self.handle(error: error)
        }
    }
    
    private func configreFrontAnkleLineGrpah(data: [Data]) {
        self.frontAnkleLineGraph.setTitle("Front Ankle Temperature")
        let frontAnkleData = data.filter({
            $0.dataTypeName == RequiredDataType.FRONT_ANKLE_TEMP.rawValue
        })
        self.frontAnkleLineGraph.setAndRefreshData(dataPoints: [frontAnkleData.map({CGFloat($0.value)})])
    }
    
    private func configureLeftSideAnkleLineGraph(data: [Data]) {
        self.leftSideAnkleLineGraph.setTitle("Left Ankle Temperature")
        let leftSideAnkleData = data.filter({
            $0.dataTypeName == RequiredDataType.LEFT_SIDE_ANKLE_TEMP.rawValue
        })
        self.leftSideAnkleLineGraph.setAndRefreshData(dataPoints: [leftSideAnkleData.map({CGFloat($0.value)})])
    }
    
    private func configureRightSideAnkleLineGraph(data: [Data]) {
        self.rightSideAnkleLineGraph.setTitle("Right Ankle Temperature")
        let rightSideAnkleData = data.filter({
            $0.dataTypeName == RequiredDataType.RIGHT_SIDE_ANKLE_TEMP.rawValue
        })
        self.rightSideAnkleLineGraph.setAndRefreshData(dataPoints: [rightSideAnkleData.map({CGFloat($0.value)})])
    }

    private func setSelectedActivityType(_ activityTypeId: String) {
        self.selectedActivity = self.activities.first(where: { $0.id == activityTypeId })
        guard let currentUser = self.currentUser else {
            self.handle(error: UserError.notSignedInError)
            return
        }
        
        var data: [Data]
        if (self.selectedActivity != nil) {
            data = currentUser.data.filter({$0.time/1000 <= selectedActivity!.time + selectedActivity!.duration && $0.time >=  selectedActivity!.time})
        } else {
            data = currentUser.data.filter({$0.time/1000 >= Int(Date(timeIntervalSinceNow: -60).timeIntervalSince1970)})
        }

        self.configreFrontAnkleLineGrpah(data: data)
        self.configureLeftSideAnkleLineGraph(data: data)
        self.configureRightSideAnkleLineGraph(data: data)
    }
}

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
    
    @IBOutlet var frontAnkleLineGraph: LineGraphView!
    @IBOutlet var leftSideAnkleLineGraph: LineGraphView!
    @IBOutlet var rightSideAnkleLineGraph: LineGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let currentUserData = try Model.shared.getCurrentUser().data
            self.configreFrontAnkleLineGrpah(data: currentUserData)
            self.configureLeftSideAnkleLineGraph(data: currentUserData)
            self.configureRightSideAnkleLineGraph(data: currentUserData)
        } catch {
            self.handle(error: error)
        }
    }
    
    private func configreFrontAnkleLineGrpah(data: [Data]) {
        let frontAnkleData = data.filter({
            $0.dataTypeName == RequiredDataType.FRONT_ANKLE_TEMP.rawValue
        })
        self.frontAnkleLineGraph.setAndRefreshData(dataPoints: [frontAnkleData.map({CGFloat($0.value)})])
    }
    
    private func configureLeftSideAnkleLineGraph(data: [Data]) {
        let leftSideAnkleData = data.filter({
            $0.dataTypeName == RequiredDataType.LEFT_SIDE_ANKLE_TEMP.rawValue
        })
        self.leftSideAnkleLineGraph.setAndRefreshData(dataPoints: [leftSideAnkleData.map({CGFloat($0.value)})])
    }
    
    private func configureRightSideAnkleLineGraph(data: [Data]) {
        let rightSideAnkleData = data.filter({
            $0.dataTypeName == RequiredDataType.RIGHT_SIDE_ANKLE_TEMP.rawValue
        })
        self.rightSideAnkleLineGraph.setAndRefreshData(dataPoints: [rightSideAnkleData.map({CGFloat($0.value)})])
    }
}

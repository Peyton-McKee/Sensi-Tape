//
//  ActivityViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/11/23.
//

import UIKit

class ActivityViewController: UIViewController, ErrorHandler {
    
    var userData: [Data] = []
    
    var uniqueKeys: [String] {
        var uniqueKeys: [String] = []
        for userData in self.userData {
            if !uniqueKeys.contains(userData.dataTypeName) {
                uniqueKeys.append(userData.dataTypeName)
            }
        }
        return uniqueKeys
    }
    
    var selectedActivityTypes: [String] = []
    var selectedActivityTypesSet: Set<String> = Set()
    
    var valuesToGraph : [[CGFloat]] {
        var valuesToGraph : [[CGFloat]] = []
        for selectedActivityType in selectedActivityTypes {
            let assocaitedData = self.userData.filter({ $0.dataTypeName == selectedActivityType }).map({ CGFloat($0.value) })
            valuesToGraph.append(assocaitedData)
        }
        return valuesToGraph
    }
    
    @IBOutlet var graphStackView: UIStackView!
    @IBOutlet var graphView: LineGraphView!
    @IBOutlet var graphKeyView: UIView!
    @IBOutlet var graphKeyTableView: UITableView!
    
    @IBOutlet var activityLogTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        let overlay = UIView(frame: self.view.frame)
        overlay.backgroundColor = .systemFill
//        view.addSubview(overlay)
        self.styleSections()
        self.assignCurrentUserData()
        self.activityLogTableView.delegate = self
        self.activityLogTableView.dataSource = self
        self.graphKeyTableView.delegate = self
        self.graphKeyTableView.dataSource = self
        self.activityLogTableView.contentInsetAdjustmentBehavior = .automatic
        // Do any additional setup after loading the view.
    }
    
    private func styleSections () {
        StyleManager.shared.styleViews([self.graphStackView, self.graphKeyTableView, self.activityLogTableView])
        StyleManager.shared.styleTableView(self.graphKeyTableView)
        StyleManager.shared.styleTableView(self.activityLogTableView)
    }
    
    private func assignCurrentUserData() {
        do {
            self.userData = try Model.shared.getCurrentUser().data
        } catch {
            self.handle(error: error)
        }
    }
    
    private func configureActivityGraph() {
        var dataPoints : [[CGFloat]] = []
        for activityType in selectedActivityTypes {
            let relevantData = userData.filter({ $0.dataTypeName == activityType }).map({ CGFloat($0.value) })
            dataPoints.append(relevantData)
        }
        self.graphView.setAndRefreshData(dataPoints: dataPoints)
    }
    
}

extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.activityLogTableView:
            return self.userData.count
        case self.graphKeyTableView:
            return self.selectedActivityTypes.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.recommendationTableViewCell.rawValue, for: indexPath) as! RecommendationTableViewCell
        switch tableView {
        case self.activityLogTableView:
            cell.setLabelText("\(self.userData[indexPath.row].dataTypeName) - \(self.userData[indexPath.row].value)")
        case self.graphKeyTableView:
            cell.setLabelText(self.selectedActivityTypes[indexPath.row], StyleManager.shared.getGraphColor(indexPath.row))
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableViewHeaderView()
        
        switch tableView {
        case activityLogTableView:
            view.setTitleLabelText("Activity Log")
        case graphKeyTableView:
            view.setTitleLabelText("Key")
        default:
            break
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch tableView {
        case self.activityLogTableView:
            guard (self.selectedActivityTypes.count < 4) else {
                self.handle(error: ConfigurationError.tooManySelectedActivityTypes)
                return
            }
            
            let selectedData = self.userData[indexPath.row].dataTypeName
            if !self.selectedActivityTypesSet.contains(selectedData) {
                self.selectedActivityTypesSet.insert(selectedData)
                self.selectedActivityTypes.append(selectedData)
            } else {
                self.selectedActivityTypes.remove(at: selectedActivityTypes.firstIndex(of: selectedData)!)
                self.selectedActivityTypesSet.remove(selectedData)
            }
            self.graphKeyTableView.reloadData()
            self.graphView.setAndRefreshData(dataPoints: self.valuesToGraph)
        default:
            return
        }

    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        switch tableView {
        case self.activityLogTableView:
            return true
        case graphKeyTableView:
            return false
        default:
            return false
        }
    }
}

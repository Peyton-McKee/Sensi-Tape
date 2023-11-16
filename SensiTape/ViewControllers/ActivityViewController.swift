//
//  ActivityViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/11/23.
//

import UIKit

class ActivityViewController: UIViewController, ErrorHandler {
    private var userData: [Data] = []
    
    private var uniqueKeys: [String] {
        var uniqueKeys: [String] = []
        for userData in self.userData {
            if !uniqueKeys.contains(userData.dataTypeName) {
                uniqueKeys.append(userData.dataTypeName)
            }
        }
        return uniqueKeys
    }
    
    private var sectionToData: [Int: [Data]] {
        var map = [Int: [Data]]()
        for (index, type) in self.uniqueKeys.enumerated() {
            map.updateValue(self.userData.filter({$0.dataTypeName == type}), forKey: index)
        }
        return map
    }
    
    private var selectedActivityTypes: [String] = []
    private var selectedActivityTypesSet: Set<String> = Set()
    
    private lazy var sectionIsCollapsed: [Bool] = Array(repeating: true, count: self.sectionToData.count)

    
    private var valuesToGraph : [[CGFloat]] {
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
    
    private func toggleSection(tableView: UITableView, _ section: Int) {
        self.sectionIsCollapsed[section] = !self.sectionIsCollapsed[section]
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    @objc func headerTapped(_ sender: UITapGestureRecognizer) {
        if let section = sender.view?.tag {
            self.toggleSection(tableView: self.activityLogTableView, section)
            self.updateGraphFor(self.sectionToData[section]!.first!.dataTypeName)
        }
    }
    
    func updateGraphFor(_ selectedDataType: String) {
        if !self.selectedActivityTypesSet.contains(selectedDataType) {
            self.selectedActivityTypesSet.insert(selectedDataType)
            self.selectedActivityTypes.append(selectedDataType)
        } else {
            self.selectedActivityTypes.remove(at: selectedActivityTypes.firstIndex(of: selectedDataType)!)
            self.selectedActivityTypesSet.remove(selectedDataType)
        }
        self.graphKeyTableView.reloadData()
        self.graphView.setAndRefreshData(dataPoints: self.valuesToGraph)
    }
}

extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case self.activityLogTableView:
            return self.sectionToData.count
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.activityLogTableView:
            return sectionIsCollapsed[section] ? 0 : self.sectionToData[section]!.count
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
            let data = self.sectionToData[indexPath.section]![indexPath.row]
            cell.setLabelText(data.value.description)
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
            view.setTitleLabelText(self.sectionToData[section]?.first?.dataTypeName)
            view.setBackgroundColor(.black)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.headerTapped(_:)))
            view.tag = section
            view.addGestureRecognizer(tapGesture)
        case graphKeyTableView:
            view.setTitleLabelText("Key")
        default:
            break
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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
            self.updateGraphFor(selectedData)
        default:
            return
        }

    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        switch tableView {
        case self.activityLogTableView:
            return false
        case graphKeyTableView:
            return false
        default:
            return false
        }
    }
}

//
//  RecommendationTableViewController.swift
//  SensiTape
//
//  Created by Peyton McKee on 11/18/23.
//

import UIKit

class SearchTableViewController: UITableViewController, ErrorHandler {
    
    var tags: [Tag] = []
    
    var recommendations: [Recommendation] = []
    
    var filteredData: [Recommendation] {
        guard let selection = self.selection else {
            return recommendations
        }
        
        return self.recommendations.filter({$0.tags.contains(Tag(name: selection.uppercased()))})
    }
    
    
    var selection: String? {
        didSet {
            print("SELECTION IS: \(String(describing: selection))")
        }
    }
    
    var autoCompleteTextField: AutoCompleteTextField = {
        let textfield = AutoCompleteTextField()
        textfield.font = StyleManager.getSubtitleFont()
        textfield.placeholder = "Search for a Tag"
        textfield.tintColor = UIColor.systemGray
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutAutocompleteTextField()
        self.getAllRecommendations()
        self.getAllTags()
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifier.searchTableViewCell.rawValue)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.searchTableViewCell.rawValue, for: indexPath) as! SearchTableViewCell
        let cellData = filteredData[indexPath.row]
        cell.textLabel?.font = StyleManager.getSubtitleFont()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = cellData.name + " " + cellData.tags.reduce("", {result, tag in "\(result)(\(tag.name)), "}).dropLast(2)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Model.shared.openLink(filteredData[indexPath.row].link)
    }
    
    private func getAllRecommendations() {
        APIHandler.shared.queryData(route: Route.allRecommendations(), completion: {
            result in
            do {
                let recommendations: [Recommendation] = try result.get()
                DispatchQueue.main.async {
                    self.recommendations = recommendations
                    self.tableView.reloadData()
                }
            } catch {
                self.handle(error: error)
            }
        })
    }
    
    private func getAllTags() {
        APIHandler.shared.queryData(route: Route.allTags(), completion: {
            result in
            do {
                let tags: [Tag] = try result.get()
                DispatchQueue.main.async {
                    self.tags = tags
                }
            } catch {
                self.handle(error: error)
            }
        })
    }
    
}

extension SearchTableViewController: AutoCompleteTextFieldDelegate {
    private func layoutAutocompleteTextField() {
        self.autoCompleteTextField.removeFromSuperview()
        
        let height: CGFloat = 60
        let pad: CGFloat = 16.0
        self.autoCompleteTextField.frame = CGRect(x: pad,
                                                  y: pad,
                                                  width: view.bounds.width - (pad * 2),
                                                  height: height)
        
        self.tableView.tableHeaderView = self.autoCompleteTextField
        self.autoCompleteTextField.autocompleteDelegate = self
    }
    
    func returned(with selection: String) {
        self.selection = selection
        self.tableView.reloadData()
    }
    
    func textFieldCleared() {
        self.selection = nil
        self.tableView.reloadData()
    }
    
    func provideDatasource() {
        self.autoCompleteTextField.datasource = self.tags.map({$0.name})
    }
    
}

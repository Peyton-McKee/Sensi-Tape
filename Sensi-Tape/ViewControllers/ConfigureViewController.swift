//
//  ViewController.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/4/23.
//

import UIKit

class ConfigureViewController: UIViewController, ErrorHandler{
    lazy var loadingScreen = LoadingScreen(frame: self.view.frame)
    var currentUser: AuthenticatedUser?
    var recommendations : [Exercise] = []
    
    @IBOutlet var configurationStackView: UIStackView!
    @IBOutlet var temperatureSlider: UISlider!
    @IBOutlet var compressionSlider: UISlider!
    
    @IBOutlet var activityStackView: UIStackView!
    @IBOutlet var activityGraphView: LineGraphView!
    @IBOutlet var batteryImageView: UIImageView!
    
    @IBOutlet var recommendationTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentUser()
        self.getAllExercises()
        self.recommendationTableView.dataSource = self
        self.recommendationTableView.delegate = self
        self.styleSections()
        self.setDefaults()
        self.activityGraphView.setAndRefreshData(dataPoints: [6, 5, 2, 4, 1])
        self.setBatteryImageFor(value: 56.5)
//        self.mockInputs()
    }
    
    func mockInputs () {
        DispatchQueue.global().async{
            while true {
                let rand = Int.random(in: 0..<10000)
                if (rand <= 100) {
                    self.setBatteryImageFor(value: Float(rand))
                }
                    
            }
        }
    }
    func getCurrentUser() {
        guard let userId = UserDefaults.standard.string(forKey: UserDefaultKey.userId.rawValue) else {
            self.handle(error: UserError.notSignedInError)
            return
        }
        APIHandler.queryData(route: Route.userById(userId: userId), completion: {
            result in
            do {
                self.currentUser = try result.get()
            } catch {
                DispatchQueue.main.async{
                    self.handle(error: error)
                }
            }
        })
    }
    
    func getAllExercises() {
        APIHandler.queryData(route: Route.allExercises(), completion: {
            result in
            do {
                self.recommendations = try result.get()
                DispatchQueue.main.async{
                    self.recommendationTableView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
        })
    }
    
    func setDefaults() {
        let compressionValue = UserDefaults.standard.float(forKey: UserDefaultKey.compressionValue.rawValue)
        self.compressionSlider.setValue(compressionValue, animated: false)
        let temperatureValue = UserDefaults.standard.float(forKey: UserDefaultKey.temperatureValue.rawValue)
        self.temperatureSlider.setValue(temperatureValue, animated: false)
        
    }
    
    func styleSections() {
        for view: UIView in [self.configurationStackView, self.activityStackView, self.recommendationTableView] {
            view.layer.cornerRadius = 10.0
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.white.cgColor
        }
        
        self.batteryImageView.tintColor = .gray
        self.recommendationTableView.backgroundColor = .secondarySystemFill
        self.recommendationTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func temperatureSliderChanged (sender: UISlider) {
        UserDefaults.standard.setValue(sender.value, forKey: UserDefaultKey.temperatureValue.rawValue)
    }
    
    @IBAction func compressionSliderChanged (sender: UISlider) {
        UserDefaults.standard.setValue(sender.value, forKey: UserDefaultKey.compressionValue.rawValue)
    }
    
    func setBatteryImageFor(value: Float) {
        if (value >= 95) {
            self.batteryImageView.image = .init(systemName: "battery.100")
        } else if (value >= 65) {
            self.batteryImageView.image = .init(systemName: "battery.75")
        } else if (value >= 40) {
            self.batteryImageView.image = .init(systemName: "battery.50")
        } else if (value >= 15) {
            self.batteryImageView.image = .init(systemName: "battery.25")
        } else {
            self.batteryImageView.image = .init(systemName: "battery.0")
            self.batteryImageView.tintColor = .red
        }
    }
}

extension ConfigureViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recommendations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.recommendationTableViewCell.rawValue, for: indexPath) as! RecommendationTableViewCell
        cell.label.text = self.recommendations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: self.recommendations[indexPath.row].link) else {
            self.handle(error: ConfigurationError.InvalidLink)
            return
        }
        UIApplication.shared.open(url)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear

        let titleLabel = UILabel()
        titleLabel.text = "Recommendations"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)

        headerView.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -8),
        ])

        return headerView
    }
    
}

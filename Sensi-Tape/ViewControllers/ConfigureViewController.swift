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
    
    @IBOutlet var configurationStackView: UIStackView!
    @IBOutlet var temperatureSlider: UISlider!
    @IBOutlet var compressionSlider: UISlider!
    
    @IBOutlet var activityStackView: UIStackView!
    @IBOutlet var activityGraphView: LineGraphView!
    @IBOutlet var batteryImageView: UIImageView!
    
    @IBOutlet var recommendationTableView: UITableView!
    
    var currentBatteryLife: Float = 56.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentUser()
        self.recommendationTableView.dataSource = self
        self.recommendationTableView.delegate = self
        self.styleSections()
        self.setDefaults()
        self.activityGraphView.setAndRefreshData(dataPoints: [1, 4, 5, 6])
        self.setBatteryImageFor(value: self.currentBatteryLife)
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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        return cell
    }
    
    
}
